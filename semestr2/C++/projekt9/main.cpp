#include "list.hpp"
#include "stack.hpp"
#include "queue.hpp"

using namespace std;
using namespace calc;

int main(){
	list<int> lista1 = list<int>();

	lista1.push_back(13);
	lista1.push_back(16);
	lista1.push_back(12);
	lista1.push_back(13);
	lista1.push_back(14);
	lista1.push_back(14);
	lista1.push_back(18);
	lista1.push_front(13);

	lista1.rm_all_occurences(13);

	cout << lista1.get_index(18) << endl;
	cout << lista1.size() << endl;
	cout << lista1.count(14) << endl;
	cout << "lista1: " << lista1 << endl;


	list<int> lista2 = list<int>{ 1, 2, 3, 4, 5, 6 };
	cout << lista2;

	list<int> lista3 = list<int>(lista2);
	cout << "lista3: " << lista3;

	list<int> lista4 = lista3;
	cout << "lista4: " << lista4;
	lista4.pop_front();
	cout << "lista4.pop_front(), lista3: " << lista3;
	cout << "lista4.pop_front(), lista4: " << lista4;

	list<int> lista5 = list<int>(list<int>{1, 2, 3, 4, 50});
	cout << "lista5: " << lista5;


	stack<int> stack1 = stack<int>();
	stack1.push_front(15);
	stack1.push_front(16);
	cout << "stack1: " << stack1;
	stack1.pop();
	cout << "stack1.pop(), stack1: " << stack1;
	cout << "stack1.size(): " << stack1.size() << endl;

	queue<int> queue1 = queue<int>();
	queue1.push_back(14);
	queue1.push_back(15);
	queue1.push_back(16);
	queue1.pop();
	cout << "queue1.pop(), queue1:" << queue1;
	cout << "queue1.size():" << queue1.size() << endl;



	list<int> lista6 = list<int>{ 14 };
	lista6.rm_all_occurences(14);
	cout << lista6;

	list<char> lista7 = list<char>{ 'a', 'b', 'c' };
	cout << "lista7: " << lista7;


	return 0;
}
