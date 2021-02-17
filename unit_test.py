import unittest
import Game


class Test_Game(unittest.TestCase):
    def test_isUserType(self):
        result=Game.isUserType("K")
        self.assertTrue(result)
    def test_isGender(self):
        result=Game.isGender("u")
        self.assertTrue(result)
    def test_Proper_ID(self):
        result=Game.Proper_ID("1234")
        self.assertTrue(result)
    def test_Proper_First_Or_Last_Name(self):
        result=Game.Proper_ID("$2")
        self.assertTrue(result)
    def test_Proper_Age(self):
        result=Game.Proper_Age(-1)
        self.assertTrue(result)
    def test_Check_User_Type_From_DB(self):
        result=Game.Check_User_Type_From_DB(123456789,"L")
        self.assertTrue(result)
    def test_Delete(self):
        result=Game.Delete("123456")
        self.assertTrue(result)
    def test_is_parent_of_user(self):
        result=Game.is_parent_of_user(1232132,123123123)
        self.assertTrue(result)
    def test_is_proper_time(self):
        result=Game.is_proper_time("25:00")
        self.assertTrue(result)

if __name__ == '__main__':
    unittest.main()
