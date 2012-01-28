/**
 * A file reader based on the actor threads of D to just send lines to your receiver as
 * quickly as it's available.
 *
 * Examples:
 *
 * ---
 * bool run = false;
 * ThreadReader reader = ThreadReader(thisTid); 
 * reader.tid.send("../data/testfile.txt"); // TODO: implement build directory variable
 * 
 * do{
 * 	receive(
 * 		(int code) { switch(code){
 * 			case EndOfStream:
 * 				writefln("Finished reading file");
 * 				run = false;
 * 				break;
 * 			default:
 * 				run = false;
 * 				break;
 * 		}},
 * 		(string line) { writefln("Read line: %s", line); },
 * 		(Variant any) { assert(false, "Stuff went wrong, got: "~any.toString()); }
 * 	);
 * } while(run);
 * --- 
 */
module dhe.io.read.threadreader;

import dhe.util.thread;

import std.stdio : writefln;
import std.stream;
import std.exception;
import core.vararg;

/**
 * Thread wrapper class for the reader functionality
 */
class ThreadReader : Thread{
private:
	Tid self;
public:
	/**
	 * Initializes a new threadloop, but won't start throwing lines from the file
	 * until it gets a message. It will expect a filename, including full path, 
	 * after which it will start sending line strings.
	 *
	 * Params:
	 *		receiver = Receiver of the file content
	 *
	 * See_Also: dhe.util.thread
	 */
	this(Tid receiver){
		super(receiver, &init);
	}
	unittest{
		ThreadReader reader = new ThreadReader(thisTid);
		reader.tid.send("testfile"); 
		receive(
			(int x) { assert(x == EndOfStream, 
							 "The right Tid didn't generate an end of stream with an non-existant file"); }, 
			(Variant any) { assert(false, "Stuff went wrong, got: "~any.toString()); }
		);
		delete reader;
		
		reader = new ThreadReader(thisTid);
		reader.tid.send("../data/testfile.txt");
		Tid readerTid = reader.tid;
		receive(
			(string line) { assert(line == "This is a test file", "Couldn't read a file"); },
			(Variant any) { assert(false, "Stuff went wrong, got: "~any.toString()); }
		);

		delete reader;

		receiveTimeout( 
			dur!"seconds"(1),
			(string line) { assert(line != "42", "Got one extra line"); },
			(Variant any) { assert(true, "Stuff went wrong, got: "~any.toString()); }
		);
	}

	/**
	 * Redirects a filename message to the reader thread.
	 */
	void read(string filename){
		self.send(filename);
	}
}

private:
/**
 * Waits for a message with the correct Tid as a confirmation that the
 * receiving thread is ready for input.
 *
 * Throws:
 *		ThreadException if an erroneous message was received
 */
void init(Tid receiver){
	bool failed = false;
	string filename = receiveOnly!string();

	File file;
	try{
		file = new File(filename, FileMode.In);
		loop(receiver, file);
	}
	catch(OpenException e){
		receiver.send(EndOfStream);
	}
	finally{
		if(file !is null)
			file.close();
	}
}

/**
 * Repeatedly sends rows of the file to the receiving thread.
 */
void loop(Tid receiver, File file){
	bool run = true;
	foreach(char[] line; file){
		receiver.send(line.idup);
		receiveTimeout(
			dur!"nsecs"(5), 
			(int code) { if(code == StopRequest) run = false; }
		);
		if(!run)
			break;
	}
	receiver.send(EndOfStream);
}

