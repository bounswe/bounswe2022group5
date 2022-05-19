# CMPE 352 Spring 2022 Group 5 Practice App
This is the practice-app developed by Group 5 of CMPE352 Spring 2022. This app is developed by using [Django](https://www.djangoproject.com/) and its [REST Framework](https://www.django-rest-framework.org/).

You can reach our app by this link: http://3.69.144.13:8888/

## Running the Application:
### How to run in local:
1. Clone our repo to your local:

		git clone https://github.com/bounswe/bounswe2022group5.git
		
2.  cd into the practice-app folder:

		cd practice-app
		
3. Create a virtual environment:

		python3 -m venv env
		
4. Activate the virtual environment:

		source env/bin/activate
		
5. Install the dependencies:

		python3 -m pip install -r requirements.txt
		
6. Provide the necessary environment variables for external API keys in a `.env`file in the current directory.
		
7. Run the application:

		python3 manage.py runserver
		
8. App should be available at `http://localhost:8000/`.

### How to run using docker:

1. Make sure you installed and are able to use docker. Make sure you can use `docker`command.
2. Clone our repo and cd into the practice-app. Provide a valid `.env` file to use external APIs. 
3. Create an image named `practice-app-group-5` of our app:

		docker build -t practice-app-group-5 .
		
4. Create a container and run our application:

		docker run -p 8888:8000 practice-app-group-5

5. App should be available at `http://localhost:8888/`.
Since we specified port 8000 in the Dockerfile, our app is reachable by 8000 port of the container. We created a connection between the port 8000 of the container with our localhost's 8888 port. Ports can be changed.

## How to test a specific app:
To run unit tests of a specific app inside the practice-app folder:
1. Make sure to be in the `bounswe2022group5/practice-app/` directory.
2. Run the following command for a specific app with name `app-name`:

		python3 manage.py test <app-name>
		
	For example:
		
		python3 manage.py test comment
		
