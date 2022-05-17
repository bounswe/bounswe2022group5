from django import forms
from django.urls import reverse_lazy
from .models import Article
from crispy_forms.helper import FormHelper
from crispy_forms.layout import Submit, Layout


class ArticlePostForm(forms.ModelForm):

    def __init__(self, *args, **kwargs):
        super().__init__(*args,**kwargs)
        self.helper = FormHelper(self)
        self.helper.form_method = 'POST'
        self.helper.form_action = reverse_lazy('createArticle')
        self.helper.add_input(Submit('submit', 'Create Article'))
        #self.helper.layout()

    class Meta:
        model = Article
        fields = ('title','body','category','user')

        widgets = {
            'title': forms.TextInput(attrs={'class':'form-style', 'placeholder':'Insert the title of the article'}),
            'body': forms.Textarea(attrs={'class':'form-style', 'placeholder':'Write your article body here...'}),
            'category': forms.Select(attrs={'class':'form-style'}),
            'user': forms.Select(attrs={'class':'form-style'}),
        }





