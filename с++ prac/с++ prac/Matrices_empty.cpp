#include <iostream>

using namespace std;

class Exception: public exception
{
protected:

	char* str;
public:
	Exception(const char* s)
	{
		str = new char[strlen(s) + 1];
		strcpy_s(str, strlen(s) + 1, s);
	}
	Exception(const Exception& e)
	{
		str = new char[strlen(e.str) + 1];
		strcpy_s(str, strlen(e.str) + 1, e.str);
	}
	~Exception()
	{
		delete[] str;
	}


	virtual void print()
	{
		cout << "Exception: " << str<< "; "<<what();
	}
};

class BaseMatrix
{
protected:
	double** ptr;
	int height;
	int width;
public:
	BaseMatrix(int Height = 2, int Width = 2)
	{

		height = Height;
		width = Width;
		ptr = new double* [height];
		for (int i = 0; i < height; i++)
			ptr[i] = new double[width];
	}

	BaseMatrix(const BaseMatrix& M)
	{
		this->height = M.height;
		this->width = M.width;

		ptr = new double* [height];

		for (int i = 0; i < height; i++)
		{
			ptr[i] = new double[width];
			for (int j = 0; j < width; j++)
				ptr[i][j] = M.ptr[i][j];
		}
	}

	~BaseMatrix()
	{
		
		if (ptr != NULL)
		{
			for (int i = 0; i < height; i++)
				delete[] ptr[i];
			delete[] ptr;
			ptr = NULL;
		}
	}

	void print()
	{
		//вывод
		for (int i = 0; i < height; i++)
		{
			for (int j = 0; j < width; j++)
				cout << ptr[i][j] << " ";
			cout << "\n";
		}
	}

	double* operator[](int index)
	{
		return ptr[index];
	}
	double& operator()(int row, int column)

	{
		return ptr[row][column];
	}

};

class Matrix : public BaseMatrix
{
public:
	Matrix(int Height = 2, int Width = 2) : BaseMatrix(Height, Width) { cout << "Matrix constructor\n"; }
	~Matrix() { cout << "destructor Matrix\n"; }

	double operator*()
	{
		double s = 1;
		for (int i = 0; i < height; i++)
		{
			// i + j = width - 1
			s *= ptr[i][width - 1 - i];
		}
		return s;
	}
};


int main()
{
	BaseMatrix M;

	M.print();
	
	char c; cin >> c;

	return 0;
}

