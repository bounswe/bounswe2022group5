To run the app:

- Create a virtual environment:

		python3 -m venv env
		python -m venv env
		
- Activate the virtual environment

		source env/bin/activate
		.\env\Scripts\activate
		
- Install the dependencies:

		python3 -m pip install -r requirements.txt
		pip install -r requirements.txt
		
- Make migrations and migrate:
		
		<fill here for unix>
		python manage.py makemigrations, python manage.py migrate
		
- Create an admin user if not exists:

		python3 manage.py createsuperuser
		python manage.py createsuperuser
		
- Run the appplication
		
		python3 manage.py runserver
		python manage.py runserver
		
