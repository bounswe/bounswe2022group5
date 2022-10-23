from django.test import TestCase
from django.contrib.auth.hashers import check_password

from backend import models
from backend import constants
from backend import utils

from tests.constants import *


class AdminTestCase(TestCase):
    def createAdmin(self):
        models.Admin.objects.create(
            email=TEST_ADMIN_EMAIL,
            password=utils.make_password(TEST_PASSWORD),
            type=constants.UserType.ADMIN.value,
            username=TEST_ADMIN_USERNAME
        )

    def setUp(self):
        self.createAdmin()
    
    def test_admin_creation(self):
        testAdmin = models.Admin.objects.get(username=TEST_ADMIN_USERNAME)

        self.assertTrue(isinstance(testAdmin, models.Admin))

        self.assertEqual(testAdmin.email, TEST_ADMIN_EMAIL)
        self.assertTrue(check_password(TEST_PASSWORD, testAdmin.password))
        self.assertEqual(str(testAdmin), TEST_ADMIN_USERNAME)
        self.assertEqual(testAdmin.type, constants.UserType.ADMIN.value)


class MemberTestCase(TestCase):
    def createMember(self, email = None, username = None):
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
            email=TEST_MEMBER_EMAIL if email == None else email,
            password=utils.make_password(TEST_PASSWORD),
            type=constants.UserType.MEMBER.value,
            username=TEST_MEMBER_USERNAME if username == None else username,
            info=member_info
        )

    def setUp(self):
        self.createMember()
    
    def test_member_creation(self):
        testMember = models.Member.objects.get(username=TEST_MEMBER_USERNAME)

        self.assertTrue(isinstance(testMember, models.Member))
        self.assertTrue(isinstance(testMember.info, models.MemberInfo))

        self.assertEqual(testMember.email, TEST_MEMBER_EMAIL)
        self.assertTrue(check_password(TEST_PASSWORD, testMember.password))
        self.assertEqual(testMember.type, constants.UserType.MEMBER.value)

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
        models.Doctor.objects.create(
            email=TEST_DOCTOR_EMAIL,
            password=utils.make_password(TEST_PASSWORD),
            type=constants.UserType.DOCTOR.value,
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
        testDoctor = models.Doctor.objects.get(email=TEST_DOCTOR_EMAIL)

        self.assertTrue(isinstance(testDoctor, models.Doctor))

        self.assertEqual(testDoctor.email, TEST_DOCTOR_EMAIL)
        self.assertTrue(check_password(TEST_PASSWORD, testDoctor.password))
        self.assertEqual(str(testDoctor), TEST_DOCTOR_FULLNAME)
        self.assertEqual(testDoctor.type, constants.UserType.DOCTOR.value)
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
                username=TEST_MEMBER_2_USERNAME
            ),
            reported_user = mtc.createMember(
                email=TEST_MEMBER_3_EMAIL,
                username=TEST_MEMBER_3_USERNAME
            ),
            message = TEST_REPORT_MESSAGE
        )

    def setUp(self):
        self.createReport()
    
    def test_report_creation(self):
        testReport = models.Report.objects.get(message=TEST_REPORT_MESSAGE)

        self.assertTrue(isinstance(testReport, models.Report))
        self.assertTrue(isinstance(testReport.reporter_user, models.User))
        self.assertTrue(isinstance(testReport.reported_user, models.User))

        self.assertEqual(str(testReport), TEST_REPORT_MESSAGE)
        self.assertIsNotNone(testReport.date)
        self.assertIsNone(testReport.reviewed_by)
        self.assertIsNone(testReport.reviewed_date)
