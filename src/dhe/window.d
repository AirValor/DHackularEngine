/**
 * Author: Aramande <aramande@hackular.com>
 * Version: 0.2
 */
module dhe.window;

import std.stdio;
import std.string;

import derelict.sdl.sdl;
import derelict.sdl.image;

/**
 * Represents a window in which your game runs, you can only have one instance.
 */
final class Window {
private:
	static Window self;
	static bool inited;
	private SDL_Surface* window;
	private SDL_Surface* icon;

	/**
	 * Generates an SDL window using the height, width and depth.
	 * 
	 * Params:
	 * 	w = width of the window
	 * 	h = height of the window
	 * 	d = colorbyte depthcount
	 *	flags = bitsensitive integer for window settings
	 */
	this(int w, int h, int d, int flags){
		window = SDL_SetVideoMode(w, h, d, flags);
	}

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
	 *	flags = bitsensitive integer for window settings
	 * Returns: The instance of Window.
	 * See_Also: addFlags(int), resize(int, int), init()
	 */
	static Window init(int w, int h, int d, int flags){
		if (self is null)
			self = new Window(w, h, d, flags);

		return self;
	}
	/** 
	 * Cannot run before window was initialized, see init(int, int, int, int).
	 * 
	 * Returns: The instance of Window.
	 * See_Also: init(int, int, int, int)
	 */
	static Window init(){
		return self;
	}

	/** 
	* Get the surface of the Window.
	*
	* Returns: The SDL_Surface of window.
	*/
	SDL_Surface* getSurface() {
		return window;
	}

	/** 
	* Set the title of the Window.
	*
	* Params:
	* 	title = title of the Window.
	*/
	void setTitle(string title) {
		SDL_WM_SetCaption(toStringz(title), null);
	}

	/** 
	* Set the icon of the Window.
	*
	* Params:
	* 	icon = path to the icon.
	*/
	void setIcon(string path) {
		icon = IMG_Load(toStringz(path));
		SDL_WM_SetIcon(icon, null);
	}

	/** */
	void resize(int x, int y){
	}

	/** Add flags to the window settings. */
	void addFlags(int flags){
	}
}
