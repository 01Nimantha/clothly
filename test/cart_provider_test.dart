import 'package:clothly/data/cart_provider.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CartProvider cartProvider;
  //Pre Test
  setUp(() {
    cartProvider = CartProvider();
  }); //setUp is called before every test
  setUpAll(() {}); //setUpAll is called before all the test
  /*
      setUp ->  test -> setUp ->  test -> setUp ->  test
      setUpAll -> test -> test -> test 
  */

  //Post Test
  tearDown(() {});
  tearDownAll(() {});
  /*
      test -> tearDown -> test -> tearDown test -> tearDown 
      test -> test -> test -> tearDownAll 
  */
  //Testing
  group("CartProvider class - ", () {
    //given when then
    test(
        "given CartProvider class when it is instantiated then value of cartArr should be 0",
        () {
      //Arrange
      // final CartProvider cartProvider = CartProvider();
      //Act
      final cartArr = cartProvider.cartArr;
      //Assert
      expect(cartArr, []);
    });

    test(
        "given CartProvider class when addtoCart method call the the cartArr should have some value",
        () {
      //Arrange
      // final CartProvider cartProvider = CartProvider();
      //Act
      cartProvider.addtoCart({"name": "Nimantha"});
      final cartArr = cartProvider.cartArr;
      //Assert
      expect(cartArr, [
        {"name": "Nimantha"}
      ]);
    });
  });
}
