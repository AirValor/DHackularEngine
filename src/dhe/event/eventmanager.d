module dhe.event.eventmanager;

import dhe.event.event;
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
	void delegate(E)[] events;

public:
	/**
	 * Register a member function to be run whenever the source shouts.
	 *
	 * Params:
	 *		event = A function that expects an instance of the event structure E.
	 */
	void register(void delegate(E) event){
		events ~= event;
	}
	unittest{
		void test(E event){ 
			writefln("Hello, %s and %s", event.data, event.source); 
		};
		register(&test);
		//assert(events[1] == &test, "Couldn't retrieve the eventlistener from the structure");
	}

	/**
	 * Notify all listeners of an event that happened.
	 *
	 * Params:
	 *		e = An instance of the event structure with relevant information
	 */
	void shout(E e){
		foreach(void delegate(E) event; events){
			event(e);
		}
	}
	unittest{
		assert(!(events[0] is null), "The previously added eventlistener was null");
	}
}

unittest{
	alias EventManager!(Event!(1, int)) runTests;
	alias EventManager!(Event!(2, int)) runTests2;
	void test(Event!(1, int) event){ 
		writefln("This was data: %s and source: %s", event.data, event.source); 
	};
	runTests.register(&test);
}

void listenSDLEvent();
void handleEvent();
void loop();
