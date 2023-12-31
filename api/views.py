from django.shortcuts import render
from django.http import HttpResponse
from rest_framework import generics
from .models import Todo
from .serializers import TodoSerializer

# Create your views here.
def index(request):
    return HttpResponse("Hello, world. You're at the api index.")

# All CRUD operations
class TodoGetCreate(generics.ListCreateAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer
    
class TodoGetUpdateDelete(generics.RetrieveUpdateDestroyAPIView):
    queryset = Todo.objects.all()
    serializer_class = TodoSerializer
    
    