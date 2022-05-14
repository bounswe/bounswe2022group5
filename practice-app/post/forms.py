from django import forms
from django.urls import reverse_lazy
from .models import Post
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit, Layout


class PostForm(forms.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args,**kwargs)
        self.helper = FormHelper(self)
        self.helper.form_method = 'POST'
        self.helper.form_action = reverse_lazy('create')
        self.helper.add_input(Submit('submit', 'Create Post'))
        #self.helper.layout()

    class Meta:
        model = Post
        fields = ('title','body','category','user','country')

        widgets = {
            'title': forms.TextInput(attrs={'class':'form-style'}),
            'body': forms.Textarea(attrs={'class':'form-style'}),
            'category': forms.Select(attrs={'class':'form-style'}),
            'user': forms.Select(attrs={'class':'form-style'}),
            'country': forms.TextInput(attrs={'class':'form-style'}),
        }

    # COUNTRY_CHOICES = (
    #         (1, ''),
    #         (2, 'Germany'),
    #         (3, 'France'),
    #     )

    # country = forms.ChoiceField(widget=forms.Select())




