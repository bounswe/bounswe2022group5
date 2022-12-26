import { render, fireEvent, screen } from '@testing-library/react';
import { toBeInTheDocument } from '@testing-library/jest-dom';
import Popup from '../components/Popup/Popup';

describe('Popup', () => {
  it('renders the popup when trigger is true', () => {
    // Render the component with test props
    render(<Popup trigger={true} setTrigger={() => {}}>Test content</Popup>);

    // Check that the popup element is rendered
    expect(screen.getByTestId('popup')).toBeInTheDocument();

    // Check that the close button is rendered
    expect(screen.getByTestId('close-btn')).toBeInTheDocument();

    // Check that the test content is rendered
    expect(screen.getByText('Test content')).toBeInTheDocument();
  });

  it('hides the popup when trigger is false', () => {
    // Render the component with test props
    render(<Popup trigger={false} setTrigger={() => {}}>Test content</Popup>);

    // Check that the popup element is not rendered
    expect(screen.queryByTestId('popup')).not.toBeInTheDocument();
  });

  it('closes the popup when the close button is clicked', () => {
    // Render the component with test props
    const setTrigger = jest.fn();
    render(<Popup trigger={true} setTrigger={setTrigger}>Test content</Popup>);

    // Simulate a click on the close button
    fireEvent.click(screen.getByTestId('close-btn'));

    // Check that the setTrigger function was called with false
    expect(setTrigger).toHaveBeenCalledWith(false);
  });
})
