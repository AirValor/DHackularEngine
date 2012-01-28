module dhe.util.thread;

public{
	import std.concurrency;
	import core.thread;
}


/**
 * Generic thread related messages to send information to another thread.
 */
enum {
	UnexpectedMessage,
	EndOfStream,
	StopRequest,
	OkMessage
}


/**
 * Wrapper class for the concurrency threads. This class is meant to be
 * inherited. Any child classes are expected to handle messages and responses 
 */
abstract class Thread{
private:
	Tid self;

public:
	this(Tid parent, void function(Tid) init){
		this.self = spawn(init, parent);
	}

	~this(){
		self.send(StopRequest);
	}

	/// Get the Tid of the thread
	@property Tid tid(){
		return self;
	}
}
