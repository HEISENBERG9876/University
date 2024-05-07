#include "list.hpp"

namespace calc {

	template <typename T>
	class queue : private list<T> {
	public:
		queue() : list<T>() {}
		queue(const queue<T>& other) : list<T>(other) {}
		queue(queue<T>&& other) : list<T>(other) {}
		queue(std::initializer_list<T> lst) : list<T>(lst) {}
		~queue() {}

		list<T>::size;
		list<T>::check_empty;
		list<T>::push_back;

		void pop(){
			if (check_empty()) {
				throw std::runtime_error("Queue is empty, can't pop_front.");
			}
			list<T>::pop_front();
		}

		friend std::ostream& operator<<(std::ostream& os, const queue <T>& s) {
			os << static_cast<const list<T>&>(s);
			return os;
		}
	};

}