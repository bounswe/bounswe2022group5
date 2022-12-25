React = require('react')
fireEvent = require('@testing-library/react')
Popup = require('../components/Popup/Popup')

test('Popup is displayed when trigger is true and closes when close button is clicked', () => {
  let trigger = true;
  const setTrigger = jest.fn(() => {
    trigger = false;
  });
  const { getByText } = jest.mock(
    <Popup trigger={trigger} setTrigger={setTrigger}>
      <p>Some content</p>
    </Popup>
  );

  // Check that the Popup is displayed
  const popup = getByText('Some content');
  expect(popup).toBeInTheDocument();

  // Find the close button and click it
  const button = getByText('Close');
  fireEvent.click(button);

  // Check that the setTrigger function was called
  expect(setTrigger).toHaveBeenCalled();

  // Check that the Popup is not displayed
  expect(popup).not.toBeInTheDocument();
});
