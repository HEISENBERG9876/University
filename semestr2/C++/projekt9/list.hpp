#pragma once
#include <iostream>
#include <ostream>
#include <initializer_list>

namespace calc {

	template <typename T>
	class list {
	private:
		class node {
		public:
			T elem;
			node* next;
			node(T elem);

		};
		node* head;
	public:
		list();
		list(T elem);
		list(const list<T>& lst);
		list(list<T>&& lst);
		list(std::initializer_list<T> lst);
		~list();

		friend std::ostream& operator<<(std::ostream& os, const list<T>& lst) {
			typename list<T>::node* current = lst.head;
			while (current != nullptr) {
				os << current->elem << " ";
				current = current->next;
			};
			return os << std::endl;
		};

		void insert(int index, T elem);
		void push_front(T elem);
		void push_back(T elem);
		void rm_index(int index);
		void pop_front();
		void rm_first_occurence(T elem);
		void rm_all_occurences(T elem);
		int get_index(T elem);
		int count(T elem);
		int size();
		bool check_empty();


	};


}