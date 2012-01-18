module dhe.event.keybinding;

import dhe.event.event;
import std.typetuple;
import derelict.sdl.sdl;

/// Rebinding the sdl name to local names
alias SDLMod Mod;
/// ditto
alias SDLKey Key;

template Tuple(E...) { alias E Tuple; }

/// Temp placeholder
/// TODO: Implement the real class in its own module
class Keyboard{
	
}

/**
 * Representing a list of keycommands with their respective functions to call
 * when that specific key combination is pushed.
 *
 * Usage is intended for normal game functionality and only supports a single
 * functions per keycombination.
 */
class Keybinding{
private:
	void delegate(Keyboard info)[Mod][Key] bindings;
public:
	/**
	 * Call this function to manually activate a specific callback function.
	 */
	void listen(Event!("SDL", Keyboard) binding){}

	/**
	 * Add a callback function to any number of pairs of modifiers and keys.
	 * 
	 * Params:
	 *		callback = Function to call whenever one of the pairs are activated
	 *		keys = Expects pairs of Mod and Key. The modifier information may be 
	 *			KMOD_NONE, but keys may not be undefined.
	 *
	 * See_Also: 
	 *		Mod, Key, http://sdl.beuc.net/sdl.wiki/SDLMod, http://sdl.beuc.net/sdl.wiki/SDLKey
	 */
	void add(T)(shared(void delegate(Keyboard info)) callback,  T keys...){}
}
