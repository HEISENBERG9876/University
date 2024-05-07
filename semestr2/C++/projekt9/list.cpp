#include "list.hpp"

namespace calc {
    template <typename T>
    list<T>::node::node(T elem) : elem(elem), next(nullptr) {};

    template <typename T>
    list<T>::list() : head(nullptr) {};

    template <typename T>
    list<T>::list(T elem) : head(new node(elem)) {};

    template <typename T>
    list<T>::list(std::initializer_list<T> lst) {
        head = nullptr;
        node* curr_node = nullptr;
        for (const T& elem : lst) {
            if (head == nullptr) {
                head = new node(elem);
                curr_node = head;
            }
            else {
                node* new_node = new node(elem);
                curr_node->next = new_node;
                curr_node = curr_node->next;
            }
        }
    }

    template <typename T>
    list<T>::list(const list<T>& other_lst) {
        head = nullptr;
        node* new_lst_curr_node = nullptr;
        node* other_lst_curr_node = other_lst.head;

        while (other_lst_curr_node != nullptr) {
            if (new_lst_curr_node == nullptr) {
                new_lst_curr_node = new node(other_lst_curr_node->elem);
                head = new_lst_curr_node;
                other_lst_curr_node = other_lst_curr_node->next;
            }
            else {
                node* new_node = new node(other_lst_curr_node->elem);
                new_lst_curr_node->next = new_node;
                new_lst_curr_node = new_lst_curr_node->next;
                other_lst_curr_node = other_lst_curr_node->next;
            }
        }
    }


    template <typename T>
    list<T>::list(list<T>&& other_lst) {
        head = other_lst.head;
        other_lst.head = nullptr;
    }


    template <typename T>
    list<T>::~list() {
        node* curr_node = head;
        while (curr_node != nullptr) {
            node* next = curr_node->next;
            delete curr_node;
            curr_node = next;
        }
    }


    template<typename T>
    void list<T>::insert(int index, T elem) {
        if (index < 0) {
            throw std::out_of_range("Index must be non-negative.");
        }
        if (index == 0) {
            node* new_node = new node(elem);
            new_node->next = head;
            head = new_node;
            return;
        }
        node* new_node = new node(elem);
        node* curr_node = head;
        node* prev_node = nullptr;
        int i = 0;
        while (i < index && curr_node != nullptr) {
            prev_node = curr_node;
            curr_node = curr_node->next;
            i++;
        }
        if (i < index) {
            throw std::out_of_range("Index out of range.");
        }
        new_node->next = curr_node;
        prev_node->next = new_node;
    }


    template <typename T>
    void list<T>::push_front(T elem) {
        insert(0, elem);
    }


    template <typename T>
    void list<T>::push_back(T elem) {
        node* new_node = new node(elem);
        node* curr_node = head;
        node* prev_node = nullptr;

        while (curr_node != nullptr) {
            prev_node = curr_node;
            curr_node = curr_node->next;
        }

        if (prev_node == nullptr) {
            head = new_node;
            return;
        }

        prev_node->next = new_node;
    }


    template <typename T>
    void list<T>::rm_index(int index) {
        node* prev_node = nullptr;
        node* curr_node = head;
        int i = 0;

        if (index == 0) {
            head = head->next;
            delete curr_node;
            return;
        }
        else {
            while (i <= index && curr_node != nullptr) {
                prev_node = curr_node;
                curr_node = curr_node->next;
                i += 1;
                if (i == index) {
                    prev_node->next = curr_node->next;
                    delete curr_node;
                    return;
                }
            }
        }
    }

    template <typename T>
    void list<T>::pop_front() {
        if (head == nullptr) {
            return;
        }
        else {
            node* head_temp = head;
            head = head->next;
            delete head_temp;
        }
    }

    template <typename T>
    void list<T>::rm_first_occurence(T elem) {
        node* curr_node = head;
        node* prev_node = nullptr;

        if (curr_node == nullptr) {
            return;
        }
        else if (curr_node->elem == elem) {
            head = curr_node->next;
            delete curr_node;
        }
        else {
            while (curr_node != nullptr) {
                if (curr_node->elem == elem) {
                    prev_node->next = curr_node->next;
                    delete curr_node;
                    return;
                }
                else {
                    prev_node = curr_node;
                    curr_node = curr_node->next;
                }
            }
        }
    }


    template <typename T>
    void list<T>::rm_all_occurences(T elem) {
        if (head == nullptr) {
            return;
        }
        while (head->elem == elem) {

            node* tmp = head;
            head = head->next;
            delete tmp;
            if (head == nullptr) {
                return;
            }
        }

        node* curr_node = head->next;
        node* prev_node = head;

        while (curr_node != nullptr) {
            if (curr_node->elem == elem) {
                prev_node->next = curr_node->next;
                node* tmp = curr_node;
                curr_node = curr_node->next;
                delete tmp;
            }

            else {
                prev_node = curr_node;
                curr_node = curr_node->next;
            }
        }
    }


    template <typename T>
    int list<T>::get_index(T elem) {
        node* curr_node = head;

        int i = 0;
        while (curr_node != nullptr) {
            if (curr_node->elem == elem) {
                return i;
            }
            i += 1;
            curr_node = curr_node->next;
        }
        return -1;
    }

    template <typename T>
    int list<T>::count(T elem) {
        node* curr_node = head;

        int i = 0;
        while (curr_node != nullptr) {
            if (curr_node->elem == elem) {
                i += 1;
            }
            curr_node = curr_node->next;
        }
        return i;
    }


    template <typename T>
    int list<T>::size() {
        node* curr_node = head;

        int size = 0;
        while (curr_node != nullptr) {
            size += 1;
            curr_node = curr_node->next;
        }
        return size;
    }


    template <typename T>
    bool list<T>::check_empty() {
        if (head == nullptr) {
            return true;
        }
        else {
            return false;
        }
    }


    template class list<int>;
    template class list<char>;


}