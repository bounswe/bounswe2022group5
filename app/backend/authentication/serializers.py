from django.contrib.auth import get_user_model
from rest_framework import serializers
from backend.models import CustomUser, Member, Doctor, Category, MemberInfo
from rest_framework.validators import UniqueValidator
from django.contrib.auth.password_validation import validate_password
import random

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
    
    date_of_birth = serializers.DateField(format="%Y-%d-%m")

    class Meta:
        model = User
        fields = ('email','password','type', 'date_of_birth')
        extra_kwargs = {
            'email': {'required': True},
            'password': {'required': True},
            'type': {'required': True},
            'date_of_birth': {'required': True}
        }
    def validate(self, attrs):
        return attrs
    def create(self, validated_data):
        user = User.objects.create(
            email=validated_data['email'],
            password=validated_data['password'],
            type=validated_data['type'],
            date_of_birth=validated_data['date_of_birth']
            
        )

        
        user.set_password(validated_data['password'])
        user.save()

        return user

class DoctorSerializer(serializers.ModelSerializer):
    user = serializers.IntegerField(source='user.id')
    full_name = serializers.CharField()
    specialization = serializers.IntegerField(source='specialization.id')
    class Meta:
        model = Doctor 
        fields = ('user', 'full_name', 'specialization')
        extra_kwargs = {
            'user': {'required': True},
            'full_name': {'required': True},
            'specialization': {'required': True}
        }
    def validate(self, attrs):
        return attrs
    def create(self, validated_data):
        doctor = Doctor.objects.create(
            user=CustomUser.objects.get(id=validated_data['user']['id']),
            full_name=validated_data['full_name'] ,
            specialization=Category.objects.get(id=validated_data['specialization']['id'])
            
        )

        doctor.save()

        return doctor

class MemberSerializer(serializers.ModelSerializer):
    user = serializers.IntegerField(source='user.id')
    member_username = serializers.CharField()
    class Meta:
        model = Member 
        fields = ('user', 'member_username',)
        extra_kwargs = {
            'user': {'required': True},
            'member_username': {'required': True},
        }
    def validate(self, attrs):
        return attrs
    def create(self, validated_data):
        member_info=MemberInfo.objects.create()
        member_info.avatar = random.randint(1, 6)

        member_info.save()

        member = Member.objects.create(
            user=CustomUser.objects.get(id=validated_data['user']['id']),
            member_username=validated_data['member_username'] ,
            # info=member_info
            info = MemberInfo.objects.create()
        )
      
        member.save()
        return member
