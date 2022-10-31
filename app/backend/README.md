## Tech Stack
The backend is developed by using [Django](https://www.djangoproject.com/) and its [REST Framework](https://www.django-rest-framework.org/).
In the database [PostgreSQL](https://www.postgresql.org/) is used.

## Running the Application:
### How to run in local:
1. Clone our repo to your local and cd into the app folder:
```sh
$ git clone https://github.com/bounswe/bounswe2022group5.git
$ cd app
```
2. Create a virtual environment to install dependencies in and activate it:
```sh
$ python3 -m venv env 
$ source env/bin/activate  
```	
   or (for Windows, there are alaternatives here) 
```sh
$ python -m venv env  
$ .\env\Scripts\activate  
```	

3. Install the dependencies:
```sh
(env)$ cd backend
(env)$ python3 -m pip install -r requirements.txt 
```	
   or 
```sh
(env)$ cd backend
(env)$ pip install -r requirements.txt
```	
		
4. Migrate and run the application:

```sh
(env)$ python manage.py migrate
(env)$ python manage.py runserver
```	
