from django import forms

class categoriesPostForm(forms.Form):
    name = forms.CharField(widget=forms.TextInput)
