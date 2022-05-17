from django.http import HttpResponseRedirect
from django.shortcuts import render

# Create your views here.
from django.http import HttpResponseRedirect
from django.contrib.auth import authenticate, login, logout
from django.urls import reverse
def Login(request):
    username = request.POST['username']
    password = request.POST['password']
    user = authenticate(request, username=username, password=password)
    if user is not None:
        login(request, user)
        print(reverse('main'))
        next = request.POST.get('next', '/')
        print(next)
        return HttpResponseRedirect(next)
       
        
    else:
        next = request.POST.get('next', '/')
        return HttpResponseRedirect(next+"?isFailed=True")

def Logout(request):
    if request.user.is_authenticated:
        logout(request)
        next = request.POST.get('next', '/')
        print(next)
        return HttpResponseRedirect(next)
def main(request):
    print("darari")
    if not request.user.is_authenticated:
        is_failed = request.GET.get("isFailed",False) 
        if is_failed:
            return render(request,'login.html',{"is_failed":is_failed})
        return render(request, 'login.html')
    else:
        return render(request,"HomePage.html")

