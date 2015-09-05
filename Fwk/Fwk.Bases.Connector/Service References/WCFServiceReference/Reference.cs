﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.18052
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Fwk.Bases.Connector.WCFServiceReference {
    
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.ServiceContractAttribute(ConfigurationName="WCFServiceReference.IFwkService")]
    public interface IFwkService {
        
        [System.ServiceModel.OperationContractAttribute(Action="http://tempuri.org/IFwkService/ExecuteService", ReplyAction="http://tempuri.org/IFwkService/ExecuteServiceResponse")]
        Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceResponse ExecuteService(Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceRequest request);
        
        [System.ServiceModel.OperationContractAttribute(AsyncPattern=true, Action="http://tempuri.org/IFwkService/ExecuteService", ReplyAction="http://tempuri.org/IFwkService/ExecuteServiceResponse")]
        System.IAsyncResult BeginExecuteService(Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceRequest request, System.AsyncCallback callback, object asyncState);
        
        Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceResponse EndExecuteService(System.IAsyncResult result);
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.MessageContractAttribute(WrapperName="ExecuteService", WrapperNamespace="http://tempuri.org/", IsWrapped=true)]
    public partial class ExecuteServiceRequest {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://tempuri.org/", Order=0)]
        public string providerName;
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://tempuri.org/", Order=1)]
        public string serviceName;
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://tempuri.org/", Order=2)]
        public string jsonRequets;
        
        public ExecuteServiceRequest() {
        }
        
        public ExecuteServiceRequest(string providerName, string serviceName, string jsonRequets) {
            this.providerName = providerName;
            this.serviceName = serviceName;
            this.jsonRequets = jsonRequets;
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    [System.ServiceModel.MessageContractAttribute(WrapperName="ExecuteServiceResponse", WrapperNamespace="http://tempuri.org/", IsWrapped=true)]
    public partial class ExecuteServiceResponse {
        
        [System.ServiceModel.MessageBodyMemberAttribute(Namespace="http://tempuri.org/", Order=0)]
        public string ExecuteServiceResult;
        
        public ExecuteServiceResponse() {
        }
        
        public ExecuteServiceResponse(string ExecuteServiceResult) {
            this.ExecuteServiceResult = ExecuteServiceResult;
        }
    }
    
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public interface IFwkServiceChannel : Fwk.Bases.Connector.WCFServiceReference.IFwkService, System.ServiceModel.IClientChannel {
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class ExecuteServiceCompletedEventArgs : System.ComponentModel.AsyncCompletedEventArgs {
        
        private object[] results;
        
        public ExecuteServiceCompletedEventArgs(object[] results, System.Exception exception, bool cancelled, object userState) : 
                base(exception, cancelled, userState) {
            this.results = results;
        }
        
        public Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceResponse Result {
            get {
                base.RaiseExceptionIfNecessary();
                return ((Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceResponse)(this.results[0]));
            }
        }
    }
    
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.ServiceModel", "4.0.0.0")]
    public partial class FwkServiceClient : System.ServiceModel.ClientBase<Fwk.Bases.Connector.WCFServiceReference.IFwkService>, Fwk.Bases.Connector.WCFServiceReference.IFwkService {
        
        private BeginOperationDelegate onBeginExecuteServiceDelegate;
        
        private EndOperationDelegate onEndExecuteServiceDelegate;
        
        private System.Threading.SendOrPostCallback onExecuteServiceCompletedDelegate;
        
        public FwkServiceClient() {
        }
        
        public FwkServiceClient(string endpointConfigurationName) : 
                base(endpointConfigurationName) {
        }
        
        public FwkServiceClient(string endpointConfigurationName, string remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public FwkServiceClient(string endpointConfigurationName, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(endpointConfigurationName, remoteAddress) {
        }
        
        public FwkServiceClient(System.ServiceModel.Channels.Binding binding, System.ServiceModel.EndpointAddress remoteAddress) : 
                base(binding, remoteAddress) {
        }
        
        public event System.EventHandler<ExecuteServiceCompletedEventArgs> ExecuteServiceCompleted;
        
        public Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceResponse ExecuteService(Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceRequest request) {
            return base.Channel.ExecuteService(request);
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        public System.IAsyncResult BeginExecuteService(Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceRequest request, System.AsyncCallback callback, object asyncState) {
            return base.Channel.BeginExecuteService(request, callback, asyncState);
        }
        
        [System.ComponentModel.EditorBrowsableAttribute(System.ComponentModel.EditorBrowsableState.Advanced)]
        public Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceResponse EndExecuteService(System.IAsyncResult result) {
            return base.Channel.EndExecuteService(result);
        }
        
        private System.IAsyncResult OnBeginExecuteService(object[] inValues, System.AsyncCallback callback, object asyncState) {
            Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceRequest request = ((Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceRequest)(inValues[0]));
            return this.BeginExecuteService(request, callback, asyncState);
        }
        
        private object[] OnEndExecuteService(System.IAsyncResult result) {
            Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceResponse retVal = this.EndExecuteService(result);
            return new object[] {
                    retVal};
        }
        
        private void OnExecuteServiceCompleted(object state) {
            if ((this.ExecuteServiceCompleted != null)) {
                InvokeAsyncCompletedEventArgs e = ((InvokeAsyncCompletedEventArgs)(state));
                this.ExecuteServiceCompleted(this, new ExecuteServiceCompletedEventArgs(e.Results, e.Error, e.Cancelled, e.UserState));
            }
        }
        
        public void ExecuteServiceAsync(Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceRequest request) {
            this.ExecuteServiceAsync(request, null);
        }
        
        public void ExecuteServiceAsync(Fwk.Bases.Connector.WCFServiceReference.ExecuteServiceRequest request, object userState) {
            if ((this.onBeginExecuteServiceDelegate == null)) {
                this.onBeginExecuteServiceDelegate = new BeginOperationDelegate(this.OnBeginExecuteService);
            }
            if ((this.onEndExecuteServiceDelegate == null)) {
                this.onEndExecuteServiceDelegate = new EndOperationDelegate(this.OnEndExecuteService);
            }
            if ((this.onExecuteServiceCompletedDelegate == null)) {
                this.onExecuteServiceCompletedDelegate = new System.Threading.SendOrPostCallback(this.OnExecuteServiceCompleted);
            }
            base.InvokeAsync(this.onBeginExecuteServiceDelegate, new object[] {
                        request}, this.onEndExecuteServiceDelegate, this.onExecuteServiceCompletedDelegate, userState);
        }
    }
}
