// ConsoleApplication1.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//

#include <iostream>
using namespace std;

class MyArrayParent
{
protected:
	//сколько памяти выделено?
	int capacity;
	//количество элементов - сколько памяти используем
	int count;
	//массив

public:
	double* ptr;
	//конструкторы и деструктор
	MyArrayParent(int Dimension = 100)
	{
		cout << "\nMyArrayParent constructor " << this;
		//выделить память под массив ptr, заполнить поля
		ptr = new double[Dimension];
		capacity = Dimension;
		count = 0;
	}
	//конструктор принимает существующий массив
	MyArrayParent(double* arr, int len)
	{
		cout << "\nMyArrayParent constructor " << this;
		//заполнить массив ptr, заполнить поля
		ptr = new double[len];
		capacity = len;
		count = len;
		for (int i = 0; i < len; i++)
		{
			ptr[i] = arr[i];
		}
	}

	MyArrayParent(const MyArrayParent& P)
	{
		cout << "\nCopy constructor";
		this->count = P.count;
		this->capacity = P.capacity;
		this->ptr = new double[capacity];
		for (int i = 0; i < count; i++)
			this->ptr[i] = P.ptr[i];
	}

	MyArrayParent& operator=(const MyArrayParent& P)
	{
		cout << "\noperator=";
		//почистить ptr
		if (this->capacity < P.capacity)
		{
			delete[] ptr;
			this->capacity = P.capacity;
			ptr = new double[capacity];
		}
		//delete[] ptr;
		this->count = P.count;
		for (int i = 0; i < count; i++)
			this->ptr[i] = P.ptr[i];

		return *this;
	}

	//деструктор
	~MyArrayParent()
	{
		cout << "\nMyArrayParent destructor";
		//освободить память, выделенную под ptr
		delete[] ptr;
	}

	//обращение к полям
	int Capacity() { return capacity; }
	int Size() { return count; }
	double GetComponent(int index)
	{
		if (index >= 0 && index < count)
			return ptr[index];
		//сгенерировать исключение, если индекс неправильный
		return -1;
	}
	void SetComponent(int index, double value)
	{
		if (index >= 0 && index < count)
			ptr[index] = value;
		//сгенерировать исключение, если индекс неправильный
		else
		{
			throw "Negative index!";
		}
	}

	//добавление в конец нового значения
	void push(double value)
	{
		if (count < capacity)
		{
			ptr[count] = value;
			count++;
		}
		// добавление элемента в случае переполнения 
		else
		{
			capacity++;
			count++;
			double* ptr2 = new double[capacity];

			for (int i = 0; i < capacity - 1; i++)
			{
				ptr2[i] = ptr[i];
			}

			delete[] ptr;
			ptr = ptr2;

			ptr[capacity] = value;
		}
		
	}

	//удаление элемента с конца
	void RemoveLastValue()
	{
		if (count > 0)
		{
			ptr[count - 1] = 0;
			count--;
		}
		//что делаем, если пуст?

		else
		{
			throw "No elements in array!";
		}
		
	}

	double& operator[](int index)
	{
		//перегрузка оператора []
		return ptr[index];
	}

	void print()
	{
		cout << "\nMyArrParent, size: " << count << ", values: {";
		int i = 0;
		for (i = 0; i < count; i++)
		{
			cout << ptr[i];
			if (i != count - 1)
				cout << ", ";
		}
		cout << "}";
	}

};

class MyArrayChild : public MyArrayParent
{
public:
	//используем конструктор родителя. Нужно ли что-то ещё?
	MyArrayChild(int Dimension = 100)  : MyArrayParent(Dimension)            { cout << "\nMyArrayChild constructor"; }
	MyArrayChild(double* arr, int len) : MyArrayParent(double* arr, int len) { cout << "\nMyArrayChild constructor"; }

	~MyArrayChild() { cout << "\nMyArrayChild destructor\n"; }

	//поиск элемента
	int IndexOf(double value, bool bFindFromStart = true)
	{
		int i = 0;
		if (bFindFromStart == true)
		{
			for (i = 0; i < count; i++)
			{
				if (ptr[i] == value)
					return i;
			}

		}
		else
		{
			for (i = count - 1; i >= 0; i--)
			{
				if (ptr[i] == value)
					return i;
			}
		}
		return -1;
	}

	//удаление элемента
	void RemoveAt(int index = -1)
	{
		if (count == 0) return;
		if (index == -1)
		{
			RemoveLastValue();
			return;
		}
		for (int i = index; i < count - 1; i++)
			ptr[i] = ptr[i + 1];

		count--;
	}

	//вставка элемента
	void InsertAt(double value, int index = -1)
	{
		if (index == -1 || index == count)
			push(value);
		if (index<0 || index>count) return;

		for (int i = count; i > index; i--)
			ptr[i] = ptr[i - 1];

		ptr[index] = value;
		count++;
	}

	//удаление элемента
	//void RemoveAt(int index = -1);

	//поиск элемента
	//void IndexOf(double value, bool bFindFromStart = true);

	//вставка элемента
	//void InsertAt(double value, int index = -1);

	//выделение подпоследовательности
	//MyArrayChild SubSequence(int StartIndex = 0, int Length = -1)

	//добавление элемента в конец
	//operator + ?


};

class MySortedArray : public MyArrayChild
{
protected:
	int BinSearch(double value, int left, int right)
	{
		int middle = (left + right) / 2;

		//база рекурсии
		if (ptr[middle] == value)
			return middle;
		if (count == 1) return -1;
		if (left + 1 == right)
		{
			if (ptr[right] == value) return right;
			return -1;
		}

		if (ptr[middle] > value) return BinSearch(value, left, middle);
		if (ptr[middle] < value) return BinSearch(value, middle, right);
	}

	int BinSearch_insert(double value, int left, int right)
	{
		int middle = (left + right) / 2;

		//база рекурсии
		if (ptr[middle] == value)
			return middle;
		if (count == 1)
		{
			if (ptr[0] > value) return 0;
			return 1;
		}
		if (left + 1 == right)
		{
			if (ptr[left] > value) return left;
			if (ptr[right] < value) return right + 1;
			return right;
		}

		if (ptr[middle] > value) return BinSearch_insert(value, left, middle);
		if (ptr[middle] < value) return BinSearch_insert(value, middle, right);
	}
public:
	//используем конструктор родителя. Нужно ли что-то ещё?
	MySortedArray(int Dimension = 100) : MyArrayChild(Dimension) { cout << "\nMySortedArray constructor"; }
	~MySortedArray() { cout << "\nMySortedArray destructor\n"; }

	int IndexOf(double value, bool bFindFromStart = true)
	{
		return BinSearch(value, 0, count - 1);
	}

	void push(double value)
	{
		if (count == 0)
		{
			MyArrayParent::push(value);
			return;
		}
		int index = BinSearch_insert(value, 0, count - 1);
		InsertAt(value, index);
	}
};

void f(MyArrayParent s)
{
	cout << "\nIn f(): ";
	cout << s.ptr;
	s.print();
}

void g(int* t)
{
	*t = 10;
}

void HandleArray(double* arr, int len, double& min, double& max, double& mean)
{
	//дз
}

int main()
{
	int x = 1; int* p; p = &x; g(p); cout << x << "\n";
	if (true)
	{
		MyArrayParent arr;
		MyArrayParent p = arr;
		cout << "\n" << arr.ptr;
		//MySortedArray arr;
		int i = 0;
		for (i = 10; i >= 0; i--)
		{
			arr.push(i + 1);
			//cout << "\nInserting "<<i+1<<": \t"; arr.print();
		}
		//arr.RemoveLastValue();
		//arr.RemoveAt(6);
		//arr.InsertAt(5, 3);
		f(arr);

		cout << "\n"; arr.print();
		//double d = arr.GetComponent(5); //arr[5]
		//cout << "\nFind 8: " << arr.IndexOf(8)<< "\tFind 6.5: " << arr.IndexOf(6.5);
		//cout << "\n" << sp << "\n";
	}
	char c; cin >> c;
	return 0;
}

// Запуск программы: CTRL+F5 или меню "Отладка" > "Запуск без отладки"
// Отладка программы: F5 или меню "Отладка" > "Запустить отладку"

// Советы по началу работы 
//   1. В окне обозревателя решений можно добавлять файлы и управлять ими.
//   2. В окне Team Explorer можно подключиться к системе управления версиями.
//   3. В окне "Выходные данные" можно просматривать выходные данные сборки и другие сообщения.
//   4. В окне "Список ошибок" можно просматривать ошибки.
//   5. Последовательно выберите пункты меню "Проект" > "Добавить новый элемент", чтобы создать файлы кода, или "Проект" > "Добавить существующий элемент", чтобы добавить в проект существующие файлы кода.
//   6. Чтобы снова открыть этот проект позже, выберите пункты меню "Файл" > "Открыть" > "Проект" и выберите SLN-файл.