To run the app:

- Create a virtual environment:

		python3 -m venv env

- Activate the virtual environment

		source env/bin/activate

- Install the dependencies:

		python3 -m pip install -r requirements.txt

- Create an admin user if not exists:

		python3 manage.py createsuperuser

- Run the appplication
		
		python3 manage.py runserver
		
