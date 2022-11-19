from django.contrib.auth import get_user_model
from rest_framework import serializers
from backend.models import CustomUser
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    
    class Meta:
        User = get_user_model()
        model = User
        fields = ('email', 'password','type')
        extra_kwargs = {'password': {'write_only': True, 'required': False}}
    def create(self, validated_data):
        
        user = User.objects.create_user(**validated_data)
        return user

class RegistrationSerializer(serializers.ModelSerializer):
    
    email = serializers.EmailField(
                required=True,
                validators=[UniqueValidator(queryset=User.objects.all())]
            )

    password = serializers.CharField(write_only=True, required=True, validators=[validate_password])
    
    
    class Meta:
        model = User
        fields = ('email','password','type')
        extra_kwargs = {
            'email': {'required': True},
            'password': {'required': True},
            'type': {'required': True}
        }
    def validate(self, attrs):
        return attrs
    def create(self, validated_data):
        user = User.objects.create(
            email=validated_data['email'],
            password=validated_data['password'],
            type=validated_data['type']
            
        )

        
        user.set_password(validated_data['password'])
        user.save()

        return user