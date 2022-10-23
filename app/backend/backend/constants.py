from enum import Enum

"""
c = UserType.ADMIN
print(c) -> UserType.ADMIN
print(c.name) -> ADMIN
print(c.value) -> 0
print(c is UserType.ADMIN) -> True
"""
class UserType(Enum):
    ADMIN = 0
    DOCTOR = 1
    MEMBER = 2
