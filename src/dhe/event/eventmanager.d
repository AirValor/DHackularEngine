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
	 * Register a member function to be run whenever this source 
	 */
	void register(void delegate(E) event){
		events ~= event;
	}
	unittest{
		void test(E event){ 
			writefln("Hello, %s and %s", event.data, event.source); 
		};
		register(&test);
		assert(events[1] == &test, "Couldn't retrieve the eventlistener from the structure");
	}

	void shout(E e){
		foreach(void delegate(E) event; events){
			event(e);
		}
	}
	unittest{
		assert(!(events[0] is null), "The previously added eventlistener was null");
		E temp = E();
		temp.data = 5;
		shout(temp);
		temp.data = 10;
		shout(temp);
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
