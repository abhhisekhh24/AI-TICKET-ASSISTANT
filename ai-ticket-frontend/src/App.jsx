import { Fragment } from "react";

function App() {
  return (
    <Fragment>
      <div className="min-h-screen bg-base-200">
        {/* App component - this is imported but not used in main routing */}
        <div className="container mx-auto p-4">
          <h1 className="text-3xl font-bold text-center">AI Ticket Assistant</h1>
        </div>
      </div>
    </Fragment>
  );
}

export default App;