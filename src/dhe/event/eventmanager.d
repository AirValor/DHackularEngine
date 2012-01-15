module dhe.event.eventmanager;

import dhe.event.event;

template EventManager(E : Event!(Source, Data)){
	private:
		void delegate(E)[] events;

		/**
		 *
		 */
		void register(void delegate(E) ){
			
		}
		unittest{
			//register(void delegate())
			assert(1==2, "asdf");
		}

		void shout(E);
}

void listenSDLEvent();
void handleEvent();
void loop();
