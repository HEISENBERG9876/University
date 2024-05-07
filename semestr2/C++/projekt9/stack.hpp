#include "list.hpp"

namespace calc {

	template <typename T>
	class stack : private list<T> {
	public:
		stack() : list<T>() {}
		stack(const stack<T>& other) : list<T>(other) {}
		stack(stack<T>&& other) : list<T>(other) {}
		stack(std::initializer_list<T> lst) : list<T>(lst) {}
		~stack() {}

		list<T>::size;
		list<T>::check_empty;
		list<T>::push_front;
		
		void pop() {
			if (check_empty()) {
				throw std::runtime_error("Stack is empty, can't pop_front.");
			}
			list<T>::pop_front();
		}
		
		friend std::ostream& operator<<(std::ostream& os, const stack<T>& s) {
			os << static_cast<const list<T>&>(s);
			return os;
		}
	};

}