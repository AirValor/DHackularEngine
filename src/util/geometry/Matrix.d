module dhe.util.geometry.matrix;

template Matrix(T) {
	private int columns;
	private int rows;
	private T data;

	this(int columns, int rows) {
		this.columns = columns;
		this.rows = rows;
		data = columns * rows;
	}
}