from django.test import TestCase
from django.contrib.auth.hashers import check_password

from backend import models
from backend import constants

from tests.constants import *

import django.contrib.auth.hashers

def make_password(password):
    assert password
    return django.contrib.auth.hashers.make_password(
        password=password
    )


class AdminTestCase(TestCase):
    def createAdmin(self):
        custom_user =  models.CustomUser.objects.create(
            email=TEST_ADMIN_EMAIL,
            password = make_password(TEST_PASSWORD),
            type = constants.UserType.ADMIN.value,
        )
        models.CustomAdmin.objects.create(
            user = custom_user,
            admin_username=TEST_ADMIN_USERNAME
        )

    def setUp(self):
        self.createAdmin()
    
    def test_admin_creation(self):
        testAdmin = models.CustomAdmin.objects.get(admin_username=TEST_ADMIN_USERNAME)

        self.assertTrue(isinstance(testAdmin, models.CustomAdmin))

        self.assertEqual(testAdmin.user.email, TEST_ADMIN_EMAIL)
        self.assertTrue(check_password(TEST_PASSWORD, testAdmin.user.password))
        self.assertEqual(str(testAdmin), TEST_ADMIN_USERNAME)
        self.assertEqual(testAdmin.user.type, constants.UserType.ADMIN.value)


class MemberTestCase(TestCase):
    def createMember(self, email = None, member_username = None):
        custom_user =  models.CustomUser.objects.create(
            email=TEST_MEMBER_EMAIL if email == None else email,
            password=make_password(TEST_PASSWORD),
            type=constants.UserType.MEMBER.value,
        )
        member_info = models.MemberInfo.objects.create(
            firstname = TEST_MEMBER_FIRSTNAME,
            lastname = TEST_MEMBER_LASTNAME,
            address = TEST_MEMBER_ADDRESS,
            weight = TEST_MEMBER_WEIGHT,
            height = TEST_MEMBER_HEIGHT,
            age = TEST_MEMBER_AGE,
            past_illnesses = TEST_MEMBER_PAST_ILLNESSES,
            allergies = TEST_MEMBER_ALLERGIES,
            chronic_diseases = TEST_MEMBER_CHRONIC_DISEASES,
            undergone_operations = TEST_MEMBER_UNDERGONE_OPERATIONS,
            used_drugs = TEST_MEMBER_USED_DRUGS
        )
        return models.Member.objects.create(
            user = custom_user,
            member_username=TEST_MEMBER_USERNAME if member_username == None else member_username,
            info=member_info
        )

    def setUp(self):
        self.createMember()
    
    def test_member_creation(self):
        testMember = models.Member.objects.get(member_username=TEST_MEMBER_USERNAME)

        self.assertTrue(isinstance(testMember, models.Member))
        self.assertTrue(isinstance(testMember.info, models.MemberInfo))

        self.assertEqual(testMember.user.email, TEST_MEMBER_EMAIL)
        self.assertTrue(check_password(TEST_PASSWORD, testMember.user.password))
        self.assertEqual(testMember.user.type, constants.UserType.MEMBER.value)

        self.assertNotEqual(str(testMember), "")
        self.assertNotEqual(str(testMember), " ")

        self.assertEqual(testMember.info.firstname, TEST_MEMBER_FIRSTNAME)
        self.assertEqual(testMember.info.lastname, TEST_MEMBER_LASTNAME)
        self.assertEqual(testMember.info.address, TEST_MEMBER_ADDRESS)
        self.assertEqual(testMember.info.weight, TEST_MEMBER_WEIGHT)
        self.assertEqual(testMember.info.height, TEST_MEMBER_HEIGHT)
        self.assertEqual(testMember.info.age, TEST_MEMBER_AGE)
        self.assertEqual(
            testMember.info.past_illnesses, 
            TEST_MEMBER_PAST_ILLNESSES
        )
        self.assertEqual(
            testMember.info.allergies, 
            TEST_MEMBER_ALLERGIES
        )
        self.assertEqual(
            testMember.info.chronic_diseases, 
            TEST_MEMBER_CHRONIC_DISEASES
        )
        self.assertEqual(
            testMember.info.undergone_operations, 
            TEST_MEMBER_UNDERGONE_OPERATIONS
        )
        self.assertEqual(
            testMember.info.used_drugs, 
            TEST_MEMBER_USED_DRUGS
        )


class DoctorTestCase(TestCase):
    def createDoctor(self):
        custom_user =  models.CustomUser.objects.create(
            email=TEST_DOCTOR_EMAIL,
            password=make_password(TEST_PASSWORD),
            type=constants.UserType.DOCTOR.value,
        )
        models.Doctor.objects.create(
            user = custom_user,
            full_name=TEST_DOCTOR_FULLNAME,
            hospital_name=TEST_DOCTOR_HOSPITAL_NAME,
            specialization=models.Category.objects.create(
                name=TEST_CATEGORY_NAME,
                definition=TEST_CATEGORY_DEFINITION
            )
        )

    def setUp(self):
        self.createDoctor()
    
    def test_doctor_creation(self):
        user = models.CustomUser.objects.get(email=TEST_DOCTOR_EMAIL)
        testDoctor = models.Doctor.objects.get(user=user)

        self.assertTrue(isinstance(testDoctor, models.Doctor))

        self.assertEqual(testDoctor.user.email, TEST_DOCTOR_EMAIL)
        self.assertTrue(check_password(TEST_PASSWORD, testDoctor.user.password))
        self.assertEqual(str(testDoctor), TEST_DOCTOR_FULLNAME)
        self.assertEqual(testDoctor.user.type, constants.UserType.DOCTOR.value)
        self.assertEqual(testDoctor.verified, False)
        self.assertEqual(testDoctor.hospital_name, TEST_DOCTOR_HOSPITAL_NAME)

        self.assertTrue(isinstance(testDoctor.specialization, models.Category))
        self.assertEqual(testDoctor.specialization.name, TEST_CATEGORY_NAME)
        self.assertEqual(
            testDoctor.specialization.definition, 
            TEST_CATEGORY_DEFINITION
        )


class ReportTestCase(TestCase):
    def createReport(self):
        mtc = MemberTestCase()
        models.Report.objects.create(
            reporter_user = mtc.createMember(
                email=TEST_MEMBER_2_EMAIL,
                member_username=TEST_MEMBER_2_USERNAME
            ).user,
            reported_user = mtc.createMember(
                email=TEST_MEMBER_3_EMAIL,
                member_username=TEST_MEMBER_3_USERNAME
            ).user,
            message = TEST_REPORT_MESSAGE
        )

    def setUp(self):
        self.createReport()
    
    def test_report_creation(self):
        testReport = models.Report.objects.get(message=TEST_REPORT_MESSAGE)

        self.assertTrue(isinstance(testReport, models.Report))
        self.assertTrue(isinstance(testReport.reporter_user, models.CustomUser))
        self.assertTrue(isinstance(testReport.reported_user, models.CustomUser))

        self.assertEqual(str(testReport), TEST_REPORT_MESSAGE)
        self.assertIsNotNone(testReport.date)
        self.assertIsNone(testReport.reviewed_by)
        self.assertIsNone(testReport.reviewed_date)
