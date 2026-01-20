interface "BSB Cust. Book Check Step"
{
    procedure Execute(Customer: Record Customer): Text;
    procedure GetSequence(): Integer;
    procedure IsEnabled(Customer: Record Customer): Boolean;
}