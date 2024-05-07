from __future__ import annotations
from sqlalchemy.orm import DeclarativeBase, Session
from sqlalchemy import Table, Column, Integer, ForeignKey, String, DateTime, create_engine, or_, and_
from sqlalchemy.orm import relationship, validates
import argparse
from datetime import datetime

# format daty oczekiwany przez inputy uzytkownika w pogramie
date_format = "%d.%m.%Y %H:%M:%S"

# jedna osoba moze uczestniczyc w wielu wydarzeniach
# na jednym wydarzeniu moze uczestniczyc wiele osob
# -> osoby_na_wydarzeniu to relacja many to many


class Base(DeclarativeBase):
    pass


osoby_na_wydarzeniu = Table(
    "osoby_na_wydarzeniu",
    Base.metadata,
    Column("wydarzenie_id", Integer, ForeignKey("Wydarzenia.id")),
    Column("osoba_id", Integer, ForeignKey("Osoby.id"))
)


class Wydarzenie(Base):  # tego typu klasy to modele inaczej, tak będę je nazywał później w programie
    __tablename__ = "Wydarzenia"
    id = Column(Integer, primary_key=True)
    rozpoczecie = Column(DateTime)
    zakonczenie = Column(DateTime)
    opis = Column(String)
    osoby = relationship("Osoba", secondary=osoby_na_wydarzeniu, back_populates="wydarzenia")

    @validates("rozpoczecie")
    def validate_rozpoczecie(self, klucz, nowa_wartosc):
        if self.zakonczenie and nowa_wartosc > self.zakonczenie:
            raise ValueError("Data zakonczenia musi byc po dacie rozpoczecia")
        return nowa_wartosc

    @validates("zakonczenie")
    def validate_zakonczenie(self, klucz, nowa_wartosc):
        if self.rozpoczecie and nowa_wartosc < self.rozpoczecie:
            raise ValueError("Data zakonczenia musi byc po dacie rozpoczecia")
        return nowa_wartosc


class Osoba(Base):
    __tablename__ = "Osoby"
    id = Column(Integer, primary_key=True)
    imie = Column(String)
    email = Column(String)
    wydarzenia = relationship("Wydarzenie", secondary=osoby_na_wydarzeniu, back_populates="osoby")

    @validates("email")
    def validate_email(self, klucz, nowa_wartosc):
        if "@" not in nowa_wartosc or "." not in nowa_wartosc:
            raise ValueError("Niepoprawny format email'a")
        return nowa_wartosc


# trzeciej tabeli nie chcialo mi sie robic

def wypisz_tabele(sesja, model):
    wiersze = sesja.query(model).all()

    if not wiersze:
        print(f"Tabela {model.__tablename__} jest pusta.")
        return

    print(f"Tabela: {model.__tablename__}\n")

    naglowki = [kolumna.name for kolumna in model.__table__.columns]
    print("\t".join(naglowki))

    for wiersz in wiersze:
        print("\t".join(str(getattr(wiersz, naglowek)) for naglowek in naglowki))
    print()


# wykrycie kolizji nie oznacza niedodania wiersza to tabeli.
def zwroc_info_o_kolizjach(sesja, nowe_rozpoczecie, nowe_zakonczenie):
    query = sesja.query(Wydarzenie).filter(
        or_(
            and_(Wydarzenie.rozpoczecie <= nowe_rozpoczecie, Wydarzenie.zakonczenie >= nowe_rozpoczecie),
            and_(Wydarzenie.rozpoczecie <= nowe_zakonczenie, Wydarzenie.zakonczenie >= nowe_zakonczenie),
            and_(Wydarzenie.rozpoczecie >= nowe_rozpoczecie, Wydarzenie.zakonczenie <= nowe_zakonczenie)
        ),
    )

    kolizje = query.all()
    for kolizja in kolizje:
                print(f"~UWAGA: nowo dodane wydarzenie koliduje z wydarzeniem o id {kolizja.id}:, "
                      f"Rozpoczęcie: {kolizja.rozpoczecie}, Zakończenie: {kolizja.zakonczenie}")

    return None


def dodaj_wiersz(sesja, model, args):
    nowy_wiersz = None
    if model == Wydarzenie:
        rozpoczecie = datetime.strptime(args.rozpoczecie, date_format) if args.rozpoczecie else datetime.now()
        zakonczenie = datetime.strptime(args.zakonczenie, date_format) if args.zakonczenie else datetime.now()
        opis = args.opis if args.opis else "Nowe wydarzenie"
        nowy_wiersz = Wydarzenie(rozpoczecie=rozpoczecie, zakonczenie=zakonczenie, opis=opis)

        zwroc_info_o_kolizjach(sesja, rozpoczecie, zakonczenie)

    elif model == Osoba:
        imie = args.imie if args.imie else ""
        email = args.email if args.email else "placeholder@mail.com"
        nowy_wiersz = Osoba(imie=imie, email=email)

    sesja.add(nowy_wiersz)
    sesja.commit()


def aktualizuj_wiersz(sesja, model, args):
    if not args.id:
        print("Podaj identyfikator wiersza do aktualizacji.")
        return

    primary_key = int(args.id)
    zmieniany_wiersz = sesja.query(model).get(primary_key)

    if not zmieniany_wiersz:
        print(f"Wiersz o id {primary_key} nie istnieje w tabeli {model.__tablename__}.")
        return

    if model == Wydarzenie:
        rozpoczecie_nowe = datetime.strptime(args.rozpoczecie, date_format) if args.rozpoczecie else zmieniany_wiersz.rozpoczecie
        zakonczenie_nowe = datetime.strptime(args.zakonczenie, date_format) if args.zakonczenie else zmieniany_wiersz.zakonczenie
        opis_nowy = args.opis if args.opis else zmieniany_wiersz.opis

        zmieniany_wiersz.rozpoczecie = rozpoczecie_nowe
        zmieniany_wiersz.zakonczenie = zakonczenie_nowe
        zmieniany_wiersz.opis = opis_nowy

        zwroc_info_o_kolizjach(sesja, rozpoczecie_nowe, zakonczenie_nowe)

    elif model == Osoba:
        zmieniany_wiersz.imie = args.imie if args.imie else zmieniany_wiersz.imie
        zmieniany_wiersz.email = args.email if args.email else zmieniany_wiersz.email

    sesja.add(zmieniany_wiersz)
    sesja.commit()


# zabrakło czasu na wyszukiwanie :(

def usun_wiersz(sesja, model, args):
    if not args.id:
        print("Podaj identyfikator wiersza do usunięcia.")
        return

    primary_key = int(args.id)
    wiersz_do_usuniecia = sesja.query(model).get(primary_key)

    if not wiersz_do_usuniecia:
        print(f"Wiersz o id {primary_key} nie istnieje w tabeli {model.__tablename__}.")
        return

    sesja.delete(wiersz_do_usuniecia)
    sesja.commit()


def main():
    parser = argparse.ArgumentParser()

    # default oznacza, co ma się wydarzyć, jeśli użytkownik nic nie poda. W takim przypadku chcemy wypisać --help, co jest robione niżej w programie.
    parser.add_argument("tabela", nargs='?', default="Default", help="Nazwa tabeli to Wydarzenia lub Osoby. Kolumny w Wydarzenia: id, rozpoczecie, zakonczenie, opis. Kolumny w Osoby: id, imie, email.")
    parser.add_argument("--wypisz", action="store_true", help="SYNTAX: Nazwa tabeli --wypisz.")
    parser.add_argument("--dodaj", action="store_true", help="SYNTAX: Nazwa tabeli --dodaj --nazwakolumny1 wartosc1 --nazwakolumny2 wartosc2 ...")
    parser.add_argument("--aktualizuj", action="store_true", help="SYNTAX Nazwa tabeli + --id + --nazwakolumny1 wartosc1 --nazwakolumny2 wartosc2 ...")
    parser.add_argument("--usun", action="store_true", help="SYNTAX: Nazwa tabeli + --id.")
    parser.add_argument("--id", help="Liczba, numer indeksu wiersza w tabeli.")
    parser.add_argument("--rozpoczecie", help="Data, format to d.m.Y H:M:S. Musi zawierać apostrofy.")
    parser.add_argument("--zakonczenie", help="Data, format to d.m.Y H:M:S. Musi zawierać apostrofy.")
    parser.add_argument("--opis", help="Ciąg znaków, musi zamierać apostrofy, jeśli zawiera spację.")
    parser.add_argument("--imie", help="Ciąg znaków, musi zamierać apostrofy, jeśli zawiera spację.")
    parser.add_argument("--email", help="Ciąg znaków, musi zawierać . i @, aby być uznanym za poprawny.")

    args = parser.parse_args()

    # tworzymy i bedziemy modyfikowac plik .db w tym samym katalogu
    engine = create_engine("sqlite:///main.db", echo=True)
    Base.metadata.create_all(engine)

    with Session(engine) as sesja:
        model = None

        # nie wiem czy da się do zrobić po ludzku, nie musząc modyfikować tutaj kodu za każdym razem, gdy dodana zostanie nowa tabela
        if args.tabela == "Wydarzenia":
            model = Wydarzenie
        elif args.tabela == "Osoby":
            model = Osoba
        elif args.tabela == "Default":
            parser.print_help()

        if model:
            if args.wypisz:
                wypisz_tabele(sesja, model)
            elif args.dodaj:
                dodaj_wiersz(sesja, model, args)
            elif args.aktualizuj:
                aktualizuj_wiersz(sesja, model, args)
            elif args.usun:
                usun_wiersz(sesja, model, args)


if __name__ == "__main__":
    main()

# chyba działa
