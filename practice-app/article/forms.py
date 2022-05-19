from django import forms
from django.urls import reverse_lazy
from .models import Article
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit


class ArticlePostForm(forms.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args,**kwargs)
        self.helper = FormHelper(self)
        self.helper.form_method = 'POST'
        self.helper.form_action = reverse_lazy('article_create')
        self.helper.add_input(Submit('submit', 'Create Article'))
        #self.helper.layout()

    class Meta:
        model = Article
        fields = ('title','body','category')

        widgets = {
            'title': forms.TextInput(attrs={'class':'form-style', 'placeholder':'Title of the article'}),
            'body': forms.Textarea(attrs={'class':'form-style', 'placeholder':'Article body'}),
            'category': forms.Select(attrs={'class':'form-style'}),
            }





