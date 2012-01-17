module dhe.event.eventmanager;

import dhe.event.event;
import std.concurrency;
import core.thread;
import std.stdio;

/**
 * Handles the events of a single type, from a single source and one kind of
 * data (if data is templated). 
 *
 * Params:
 *		E = Expected to be an Event template, but it could technically work for
 *		anything as long as someone shouts with the same alias.
 */
template EventManager(alias E){
private:
	void delegate(E)[] listeners;

	void shoutThreaded(shared(void delegate(E)) listener, E e){
		listener(e);
	}
public:
	/**
	 * Register a member function to be run whenever the source shouts.
	 *
	 * Whenever a registered listener is notified, it will be able to 
	 * access shared data in it's declaration scope.
	 *
	 * Params:
	 *		listener = A function that expects an instance of the event structure E.
	 */
	void register(shared(void delegate(E)) listener){
		listeners = listeners ~ listener;
	}
	unittest{
		void test(E event){ 
			writefln("Hello, %s and %s", event.data, event.source); 
		};
		register(&test);
		assert(!(listeners[0] is null), "The added eventlistener was null");
	}

	/**
	 * Notify all listeners of an event that happened.
	 *
	 * Spawns a new thread for each listener, so that heavy eventlistener
	 * functions don't delay the subsequent eventlisteners.
	 *
	 * Params:
	 *		e = An instance of the event structure with relevant information
	 */
	void shout(E e){
		foreach(shared(void delegate(E)) listener; listeners){
			spawn(&shoutThreaded, listener, e);
		}
	}

}

unittest{
	init();
	alias EventManager!(Event!(1, int)) runTests;
	alias EventManager!(Event!(2, int)) runTests2;
	shared int i = 10;
	void test(Event!(1, int) event){ 
		i = 42;
		//writefln("This was data: %s and source: %s", event.data, event.source); 
	};
	// Registering a new listener function
	runTests.register(&test);

	// Shouting a new event
	assert(i == 10, "Sanity test failed, i wasn't 10 anymore.");
	runTests.shout(Event!(1, int)());
	Thread.sleep(dur!("msecs")(1));
	assert(i == 42, "Threaded event failed to edit outer variable. (try again," ~
		   "might've been a timing error)");
}

private:

/**
 * Loop for the SDL event-pump, calls events with the Source as the string "SDL"
 * as identification.
 */
void listenSDLEvent(){

}

public:

/**
 * Initializes the event thread.
 */
void init(){
	listenSDLEvent();
}
