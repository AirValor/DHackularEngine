module dhe.io.read.tokenizer;

import dhe.io.read.threadreader;
import dhe.util.thread;

/**
 * Thread wrapper class for the tokenizer functionality.
 */
abstract class Tokenizer : Thread{
private:
	Tid self;

public:
	this(Tid parser){
		super(parser, &init);
		this.self = spawn(&init, parser);
	}

	/**
	 * Redirects a filename to the tokenizer thread.
	 */
	void read(string filename){
		self.send(filename);
	}
}

/**
 * Token information and content. For ease of returning.
 */
struct Token{
	/// Type of the token
	int type;

	/// Content of the token
	string value;
}

private:

void init(Tid parser){
	ThreadReader reader = new ThreadReader(thisTid);
}
