module dhe.util.resource.resource;

class Resource {
	string id;
	int refcount;

	string getID() {
		return id;
	}

	abstract Resource load();

	abstract void dispose();
}