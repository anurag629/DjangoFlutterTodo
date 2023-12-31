from django.urls import path
from . import views

urlpatterns = [
    path('', views.index, name='index'),
    path('api/', views.TodoGetCreate.as_view(), name='get_create'),
    path('api/<int:pk>/', views.TodoGetUpdateDelete.as_view(), name='get_update_delete'),
    
]
