from django.db import models

# Create your models here.
class Todo(models.Model):
    title = models.CharField(max_length=120)
    desc = models.TextField()
    isDone = models.BooleanField(default=False)
    date = models.DateTimeField(auto_now_add=True)

    def _str_(self):
        return self.title