module dhe.event.event;

/**
 * An event based on the Source instance and the Data-type
 */
struct Event(alias Source, Data){
public:
	/// Source instance information
	auto source = Source;
	/// Data from the event
	Data data;
}
unittest{
	alias Event!(1, int) one;
	alias Event!(2, int) two;
	one test1 = one();
	test1.data = 4;
	two test2 = two();
	test2.data = 2;
	assert(test1.data == 4, "Template instantiating didn't work as expected");
	assert(test2.data == 2, "Template instantiating didn't work as expected");
}
