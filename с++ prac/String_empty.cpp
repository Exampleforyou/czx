#include <iostream>
using namespace std;

class BaseString
{
protected:
	char* p;
	int len;
	int capacity;
public:
	BaseString(char* ptr)
	{
		cout<<"\nBase Constructor 1\n";
		int i = 0;
		while (ptr[i] != '\0')
		{
			i++;
		}
		len = i;
		capacity = (len + 1 > 128) ? len + 1 : 128;
		p = new char[capacity];

		for (int i = 0; i < len + 1; i++)
		{
			p[i] = ptr[i];
		}


	}

	BaseString(const char* ptr)
	{
		cout << "Base constructor const" << endl;
		int i = 0;
		while (ptr[i] != '\0')
		{
			i++;
		}
		len = i;
		capacity = (len + 1 > 128) ? len + 1 : 128;
		p = new char[capacity];

		for (int i = 0; i < len + 1; i++)
		{
			p[i] = ptr[i];
		}
	}

	BaseString(int Capacity = 128)
	{
		cout<<"\nBase Constructor 0\n";
		capacity = Capacity;
		p = new char[capacity];
		len = 0;
	}

	~BaseString()
	{
		cout<<"\nBase Destructor\n";
		if(p!=NULL)
			delete[] p;
		len = 0;
	}

	int Length() {return len;}
	int Capacity() { return capacity; }
	//char* get() {return p;}
	char& operator[](int i) {return p[i];}

	BaseString operator=(const BaseString& other)
	{
		if (this->p < other.p)
		{

		}
	}


	BaseString& operator=(BaseString& s)
	{
		cout<<"\nBase Operator = \n";
		
		return *this;
	}

	BaseString(BaseString& s)
	{
		cout<<"\nBase Copy Constructor\n";

		this->len = s.len;
		this->capacity = s.capacity;

		p = new char[capacity];
		for (int i = 0; i < len + 1; i++)
		{
			this->p[i] = s.p[i];
		}

	}

	virtual void print()
	{
		int i=0;
		while(p[i]!='\0')
		{
			cout<<p[i];
			i++;
		}
	}

	virtual int IndexOf(char c, int start_index = 0)
	{
		if (len == 0 or start_index < 0 or start_index>= len) { return -1; }

		/*
		for (int i = start_index; i < len; i++)
		{
			if (p[i] == c) { return i; }
		}
		*/

		for (char* p1 = &p[start_index]; p1!='\0'; p1++)
		{
			if (*p1 == c) return p1 - p;
		}
		return -1;
	}

	bool isPalindrome()
	{
		char* p1 = p;
		char* p2 = &p[len - 1];

		while (p1 < p2 and *p1++ == *p2--);
		return(p1 >= p2);
	}


};

class String : public BaseString
{
public:
	String(int capacity = 128) : BaseString(capacity) { cout << "String Constructor 128" << endl; }
	String(char* ptr) : BaseString(ptr) { cout << "String Constructor char" << endl; }
	String(const char* ptr) : BaseString(ptr) { cout << "String Constructor const char" << endl; }

	~String() { cout << "String desctructor\n"; }
	
	String(String& s) : BaseString((BaseString&)s) { cout << " String Copy constructor\n"; }

	int IndexOf(char c, int start_index = 0)
	{
		if (start_index == 0) start_index = len - 1;

		if (len == 0 or start_index < 0 or start_index >= len) { return -1; }
		/*
		for (int i = start_index; i > -1; i--)
			if (p[i] == c) return i;
		return -1;
		*/

		for (char* p1 = &p[start_index - 1]; p1!=p ; p1--)
		{
			if (*p1 == c) return p1 - p;
		}

	}

};

void f(String a)
{
	a.print();
}

void copy(char* source, char* dect)
{
	while (*dect++ = *source++);

	// сложный но красивый вариант
}


int main()
{
	if (true)
	{

		String s("test");
		s.print();

		cout << s.IndexOf('t') << endl;;
		/*
		BaseString s1 = s;
		s1.print();
		BaseString s2;
		s2 = s;
		s2 = s + s1;
		s2.print();
		s1 = s2 + s;
		s1.print();
		*/
	}
	char c; cin>>c;
	return 0;
}

