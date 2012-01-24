module dhe.event.keybinding;

import dhe.event.event;

import std.stdio;
import std.typetuple;
import std.exception;
import std.concurrency;
import core.thread;
import core.vararg;
import core.exception;
import derelict.sdl.sdl;

/// Rebinding the sdl name to local names
alias SDLMod Mod;
/// ditto
alias SDLKey Key;

template Tuple(E...) { alias E Tuple; }

/// Temp placeholder
/// TODO: Implement the real class in its own module
struct Keyboard{
	Mod mod;
	Key key;
	this(Mod mod, Key key){
		this.mod = mod;
		this.key = key;
	}
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
	alias immutable Keyboard EventType;
	alias shared(void delegate(EventType)) Callback;
	alias Event!("SDL", EventType) EventInfo;
	bool enabled;
	Callback[Mod][Key] bindings;
	
	static void shoutThreaded(Callback callback, immutable EventType type){
		callback(type);
	}
public:
	this(){
		enabled = true;
	}

	/**
	 * Call this function to manually activate a specific callback function.
	 */
	void shout(EventInfo event){
		Mod mod = event.data.mod;
		Key key = event.data.key;
		if(!enabled){
			return;
		}
		if(mod !in bindings || key !in bindings[mod]){
			return;
		}

		spawn(&shoutThreaded, bindings[mod][key], event.data);
	}
	unittest{
		Keybinding binding = new Keybinding();
		shared int d = 42;
		void test2(EventType info){ d++; }
		binding.add(&test2, KMOD_SHIFT, SDLK_r);

		assertNotThrown!RangeError(binding.shout(EventInfo(EventType(KMOD_ALT, SDLK_r))), 
								   "Key not found shouldn't throw an error");
		assert(d == 42, "Key not found, but execution of function happened");

		binding.shout(EventInfo(EventType(KMOD_SHIFT, SDLK_r)));
		Thread.sleep(dur!"msecs"(1));
		assert(d == 43, "Key found, but execution of function didn't happen");
	}

	/**
	 * Activate or deactivate this keybinding collection.
	 *
	 * Params:
	 *		value = Defaults to true, if set to false, this keybinding
	 *		collection won't respond to events.
	 */
	void enable(bool value = true){
		enabled = value;
	}
	unittest{
		Keybinding binding = new Keybinding();
		binding.enable(false);
		shared int d = 42;
		void test2(EventType info){ d++; }
		binding.add(&test2, KMOD_SHIFT, SDLK_r);

		binding.shout(EventInfo(EventType(KMOD_SHIFT, SDLK_r)));

		void test(EventType info){}
		binding.add(&test, KMOD_SHIFT, SDLK_k);
		assertNotThrown!RangeError(binding.shout(EventInfo(EventType(KMOD_ALT, SDLK_r))), 
								   "Key not found shouldn't throw an error");

		assert(d == 42, "Shouter was disabled, but execution of function happened anyway");
	}

	/**
	 * Add a callback function to any number of pairs of modifiers and keys.
	 * 
	 * Params:
	 *		callback = Function to call whenever one of the pairs are activated
	 *		keys = Expects pairs of Mod and Key. The modifier information may be 
	 *			KMOD_NONE, but keys may not be undefined.
	 *
	 * Throws:
	 *		RangeError on a zero or uneven count of variadic arguments
	 *
	 * See_Also: 
	 *		Mod, Key, http://sdl.beuc.net/sdl.wiki/SDLMod, http://sdl.beuc.net/sdl.wiki/SDLKey
	 */
	void add(Callback callback, ...){
		if(_arguments.length % 2 != 0 || _arguments.length == 0) throw(new RangeError());

		for(ulong i = 0; i < _arguments.length;){
			Mod mod;
			Key key;
			if(_arguments[i] == typeid(Mod))
				mod = va_arg!Mod(_argptr);
			++i;
			if(_arguments[i] == typeid(Key))
				key = va_arg!Key(_argptr);
			++i;

			bindings[mod][key] = callback;
		}
	}
	unittest{
		shared double p = 3.14;
		void test(EventType info){ p = 3.1415962; }
		Keybinding binding = new Keybinding();
		assertThrown!RangeError(binding.add(&test), 
								"Zerolength keylist didn't throw an exception");
		assertThrown!RangeError(binding.add(&test, KMOD_SHIFT), 
								"Uneven keylist didn't throw an exception");
		assertThrown!RangeError(binding.add(&test, KMOD_SHIFT, SDLK_e, KMOD_ALT), 
								"Uneven keylist didn't throw an exception");

		assertNotThrown!RangeError(binding.add(&test, KMOD_SHIFT, SDLK_a), 
								   "Even keylist threw an exception");
		assertNotThrown!RangeError(binding.add(&test, KMOD_SHIFT, SDLK_s, KMOD_ALT, SDLK_r), 
								   "Even keylist threw an exception");
	}
}
