/**
 * Author: Aramande <aramande@hackular.com>
 * Version: 0.1
 */
module dhe.window;

/**
 * Represents a window in which your game runs, can only have one instance.
 */
class Window{
private:
	static Window self;
	static bool inited;

	/**
	 * Generates an SDL window using the height, width and depth.
	 * 
	 * Params:
	 * 	w = width of the window
	 * 	h = height of the window
	 * 	d = colorbyte depthcount
	 *		flags = bitsensitive integer for window settings
	 */
	this(int w, int h, int d, int flags){}

public:	
	/** 
	 * Initializes a window with parameter options, this should be the first function called.
	 * If window was already initialized, this function will just return the previous window.
	 * Enables init() to run if succeeded and returns the instance, and returns null otherwise
	 * 
	 * Params:
	 * 	w = width of the window
	 * 	h = height of the window
	 * 	d = colorbyte depthcount
	 *		flags = bitsensitive integer for window settings
	 * Returns: The instance of Window.
	 * See_Also: addFlags(int), resize(int, int), init()
	 */
	static Window init(int w, int h, int d, int flags){
		return null;
	 }
	
	/** 
	 * Cannot run before window was initialized, see init(int, int, int, int).
	 * 
	 * Returns: The instance of Window.
	 * See_Also: init(int, int, int, int)
	 */
	 static Window init(){
		return null;
	 }
	 
	 /** */
	 void resize(int x, int y){
	 }
	 
	 /** Add flags to the window settings. */
	 void addFlags(int flags){
	 }
}

void main(){

}

	