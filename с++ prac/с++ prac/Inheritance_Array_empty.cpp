﻿// ConsoleApplication1.cpp : Этот файл содержит функцию "main". Здесь начинается и заканчивается выполнение программы.
//
#pragma once
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
		capacity = (len > 128) ? len : 128;
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
		// обработка ошибочных индексов
		if (index < 0)		   { throw "Index less than zero!"; }
		if (index > count - 1) { throw "too big index"; }

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

	double IndexOf(double value)
	{
		for (int i = 0; i < count; i++)
		{
			if (ptr[i] == value) { return i; }
		}
		// если он не нашёл такого элемента и смог выйти и цикла возврат ошибки (-1)
		return -1;
	}

};

class MyArrayChild : public MyArrayParent
{
public:
	//используем конструктор родителя. Нужно ли что-то ещё?
	MyArrayChild(int Dimension = 100)  : MyArrayParent(Dimension)            { cout << "\nMyArrayChild constructor"; }
	MyArrayChild(double* arr, int len) : MyArrayParent(arr, len) { cout << "\nMyArrayChild constructor"; }

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
	virtual void InsertAt(double value, int index = -1)
	{
		if (index == -1 || index == count)
			push(value);
		if (index<0 || index>count) return;

		for (int i = count; i > index; i--)
			ptr[i] = ptr[i - 1];

		ptr[index] = value;
		count++;
	}

	//выделение подпоследовательности
	MyArrayChild SubSequence(int StartIndex = 0, int Length = -1)
	{
		// просто возвращаем копию нашего массива
		if (Length == -1 and StartIndex == 0) { return MyArrayChild(ptr, count); }

		// Нормализируем длину если она не задана
		if (Length == -1)
		{
			Length = count - StartIndex;
		}

		double* new_array = new double[Length];

		for (int i = StartIndex; i <StartIndex + Length; i++)
		{
			new_array[i - StartIndex] = ptr[i];
		}

		MyArrayChild ch = MyArrayChild(new_array, Length);
		delete[] new_array;
		return ch;
		
	}


	//operator + ?
	
	MyArrayChild operator+(const MyArrayChild& other)
	{
		int new_count = max(this->count, other.count);

		MyArrayChild new_array = MyArrayChild(new_count);

		// суммируем все элементы, которые можно суммировать
		// остальные, мы просто примишем в конце для возможности сложения массивов разной длины
		for (int i = 0; i < min(this->count, other.count); i++)
		{
			new_array.ptr[i] = this->ptr[i] + other.ptr[i];
		}
		if (new_count == this->count)
		{
			for (int i = count; i < new_count; i++)
			{
				new_array.ptr[i] = this->count;
			}
		}
		else
		{
			for (int i = count; i < new_count; i++)
			{
				new_array.ptr[i] = other.count;
			}
		}
		return new_array;
		
	}

	/*Вариант 30
	Верните из функции новый массив (типа
	MySortedArray/MyArrayChild), в котором удалены элементы,
	отклоняющиеся от среднего арифметического в массиве «очень
	далеко» (не более, чем величину p * mean(arr), где p – параметр
	функции)
*/
	double Mean()
	{
		double summ = 0;
		for (int i = 0; i < count; i++)
		{
			summ += ptr[i];
		}
		return summ / count;
	}

	virtual MyArrayChild NoMean(double p = 1)
	{
		MyArrayChild NoMean_array(count);
		double mean = this->Mean();

		for (int i, j = 0; i < count; i++)
		{
			if (ptr[i] <= p*mean)
			{
				NoMean_array.push(ptr[i]);
			}

		}
		return NoMean_array;

	}

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
	MySortedArray(double* arr, int len) : MyArrayChild(arr, len)
	{
		// bubble sort

		int i, j;
		for (i = 0; i < len - 1; i++)

			// Last i elements are already
			// in place
			for (j = 0; j < len - i - 1; j++)
				if (arr[j] > arr[j + 1])
					swap(arr[j], arr[j + 1]);
	}
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
