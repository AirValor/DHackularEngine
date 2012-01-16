module dhe.event.event;

struct Event(alias Source, Data){
public:
	static auto source = Source;
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
