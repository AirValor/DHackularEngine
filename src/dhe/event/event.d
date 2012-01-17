module dhe.event.event;

/**
 * An event based on the Source instance and the Data-type
 */
struct Event(alias Source, Data){
public:
	/// Source instance information
	static auto source = Source;
	/// Data from the event
	static Data data;
}
unittest{
	alias Event!(1, int) one;
	alias Event!(2, int) two;
	one.data = 4;
	two.data = 2;
	assert(one.data == 4, "Template instantiating didn't work as expected");
	assert(two.data == 2, "Template instantiating didn't work as expected");
}
