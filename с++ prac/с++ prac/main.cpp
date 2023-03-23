#include "Inheritance_Array_empty.cpp"

class Base
{
public:
	 void print()
	{
		cout << "Base" << endl;
	}
};

class Sub : public Base
{
public:
	void print()
	{
		cout << "Sub" << endl;
	}
};

int main()
{
	if (true)
	{
		Base basa;
		basa.print();
		Sub sub;
		sub.print();

	}

	if (false)
	{
		MyArrayParent arr;
		MyArrayParent *p = &arr;


		int i = 0;
		for (i = 10; i >= 0; i--)
		{
			arr.push(i + 1);
		}

	}
	char c; cin >> c;
	return 0;
}
