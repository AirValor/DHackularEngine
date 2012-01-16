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
			void test(E event){ writefln("Hello, %s", event); };
			register(&test);
			assert(events[0] == &test);
		}

		void shout(E){}
		unittest{
		}
}

unittest{
	alias EventManager!(Event!(1, int)) runTests;
}

void listenSDLEvent();
void handleEvent();
void loop();
