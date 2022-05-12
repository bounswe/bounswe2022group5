from django import forms
from django.urls import reverse_lazy
from .models import Post
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit


class PostForm(forms.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args,**kwargs)
        self.helper = FormHelper(self)
        self.helper.form_method = 'POST'
        self.helper.form_action = reverse_lazy('create')
        self.helper.add_input(Submit('submit', 'Create Post'))


    class Meta:
        model = Post
        fields = ('title','body','category','user','country')

        widgets = {
            'title': forms.TextInput(),
            'body': forms.Textarea(),
            'category': forms.Select(),
            'user': forms.Select(),
            'country': forms.TextInput(),
        }

    # COUNTRY_CHOICES = (
    #         (1, ''),
    #         (2, 'Germany'),
    #         (3, 'France'),
    #     )

    # country = forms.ChoiceField(widget=forms.Select())




