using System.Runtime.InteropServices;

namespace NetDll
{
    [StructLayout(LayoutKind.Sequential)]
    public struct ComplexType
    {
        [MarshalAs(UnmanagedType.BStr)]
        public string StringValue;
        [MarshalAs(UnmanagedType.U4)]
        public int IntValue;
    }
}