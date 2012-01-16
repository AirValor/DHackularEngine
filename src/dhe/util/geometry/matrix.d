module dhe.util.geometry.matrix;

import std.stdio;

/**
* Defines a Matrix
*/
class Matrix(T) {
	private uint num_columns;
	private uint num_rows;
	T data[];

	this(uint columns, uint rows) {
		num_columns = columns;
		num_rows = rows;
		data = new T[num_columns * num_rows];
	}

	unittest {
		auto matrix = new Matrix!uint(5, 4);
		assert(matrix.getColumns() == 5, "Matrix instantiation test failed.");
		assert(matrix.getRows() == 4, "Matrix instantiation test failed.");
	}

	double getColumns() { return num_columns; }
	double getRows() { return num_rows; }

	ref T opIndex(uint column, uint row) {
		return data[(row * num_columns) + column];
	}

	unittest {
		auto matrix = new Matrix!uint(5, 4);
		matrix[3, 2] = 1;
		assert(matrix[3, 2] == 1, "opIndexing error: values don't match.");
	}

	/**
	* Resizes the Matrix accordingly.
	*
	* Returns: A resized Matrix.
	*/
	void resize(uint columns, uint rows) {
		T new_data[] = new T[columns * rows];

		uint max_columns = columns >= num_columns ? num_columns : columns;
		uint max_rows = rows >= num_rows ? num_rows : rows;

		for (uint y = 0; y < max_rows; y++)
			for (uint x = 0; x < max_columns; x++) {
				new_data[(y * columns) + x] = data[(y * num_columns) + x];
			}

		num_columns = columns;
		num_rows = rows;
		data = new_data;
	}

	unittest {
		auto matrix = new Matrix!uint(5, 4);
		
		matrix.resize(10, 15);
		assert(matrix.getColumns() == 10, "Matrix resizing test failed.");
		assert(matrix.getRows() == 15, "Matrix resizing test failed.");
	}

	/**
	* Prints the contents of the Matrix
	*
	* Returns: The content.
	*/
	void printMatrix() {
		for (uint y = 0; y < num_rows; y++) {
			for (uint x = 0; x < num_columns; x++) {
				writef("[ %s ]", data[(y * num_columns) + x]);
			}
			writeln();
		}
	}
}
