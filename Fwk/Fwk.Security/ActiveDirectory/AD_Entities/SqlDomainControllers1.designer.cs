﻿#pragma warning disable 1591
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.235
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Fwk.Security.ActiveDirectory.AD_Entities
{
	using System.Data.Linq;
	using System.Data.Linq.Mapping;
	using System.Data;
	using System.Collections.Generic;
	using System.Reflection;
	using System.Linq;
	using System.Linq.Expressions;
	using System.ComponentModel;
	using System;
	
	
	[global::System.Data.Linq.Mapping.DatabaseAttribute(Name="GestionCuentas_Logs")]
	public partial class SqlDomainControllersDataContext : System.Data.Linq.DataContext
	{
		
		private static System.Data.Linq.Mapping.MappingSource mappingSource = new AttributeMappingSource();
		
    #region Extensibility Method Definitions
    partial void OnCreated();
    partial void InsertDomainControllers(DomainControllers instance);
    partial void UpdateDomainControllers(DomainControllers instance);
    partial void DeleteDomainControllers(DomainControllers instance);
    #endregion
		
		public SqlDomainControllersDataContext(string connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public SqlDomainControllersDataContext(System.Data.IDbConnection connection) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public SqlDomainControllersDataContext(string connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public SqlDomainControllersDataContext(System.Data.IDbConnection connection, System.Data.Linq.Mapping.MappingSource mappingSource) : 
				base(connection, mappingSource)
		{
			OnCreated();
		}
		
		public System.Data.Linq.Table<DomainControllers> DomainControllers
		{
			get
			{
				return this.GetTable<DomainControllers>();
			}
		}
	}
	
	[global::System.Data.Linq.Mapping.TableAttribute(Name="dbo.DomainControllers")]
	public partial class DomainControllers : INotifyPropertyChanging, INotifyPropertyChanged
	{
		
		private static PropertyChangingEventArgs emptyChangingEventArgs = new PropertyChangingEventArgs(String.Empty);
		
		private int _DCId;
		
		private int _DomainId;
		
		private string _DCHostName;
		
		private string _DCIp;
		
    #region Extensibility Method Definitions
    partial void OnLoaded();
    partial void OnValidate(System.Data.Linq.ChangeAction action);
    partial void OnCreated();
    partial void OnDCIdChanging(int value);
    partial void OnDCIdChanged();
    partial void OnDomainIdChanging(int value);
    partial void OnDomainIdChanged();
    partial void OnDCHostNameChanging(string value);
    partial void OnDCHostNameChanged();
    partial void OnDCIpChanging(string value);
    partial void OnDCIpChanged();
    #endregion
		
		public DomainControllers()
		{
			OnCreated();
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DCId", AutoSync=AutoSync.OnInsert, DbType="Int NOT NULL IDENTITY", IsPrimaryKey=true, IsDbGenerated=true)]
		public int DCId
		{
			get
			{
				return this._DCId;
			}
			set
			{
				if ((this._DCId != value))
				{
					this.OnDCIdChanging(value);
					this.SendPropertyChanging();
					this._DCId = value;
					this.SendPropertyChanged("DCId");
					this.OnDCIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DomainId", DbType="Int NOT NULL")]
		public int DomainId
		{
			get
			{
				return this._DomainId;
			}
			set
			{
				if ((this._DomainId != value))
				{
					this.OnDomainIdChanging(value);
					this.SendPropertyChanging();
					this._DomainId = value;
					this.SendPropertyChanged("DomainId");
					this.OnDomainIdChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DCHostName", DbType="VarChar(80) NOT NULL", CanBeNull=false)]
		public string DCHostName
		{
			get
			{
				return this._DCHostName;
			}
			set
			{
				if ((this._DCHostName != value))
				{
					this.OnDCHostNameChanging(value);
					this.SendPropertyChanging();
					this._DCHostName = value;
					this.SendPropertyChanged("DCHostName");
					this.OnDCHostNameChanged();
				}
			}
		}
		
		[global::System.Data.Linq.Mapping.ColumnAttribute(Storage="_DCIp", DbType="VarChar(50) NOT NULL", CanBeNull=false)]
		public string DCIp
		{
			get
			{
				return this._DCIp;
			}
			set
			{
				if ((this._DCIp != value))
				{
					this.OnDCIpChanging(value);
					this.SendPropertyChanging();
					this._DCIp = value;
					this.SendPropertyChanged("DCIp");
					this.OnDCIpChanged();
				}
			}
		}
		
		public event PropertyChangingEventHandler PropertyChanging;
		
		public event PropertyChangedEventHandler PropertyChanged;
		
		protected virtual void SendPropertyChanging()
		{
			if ((this.PropertyChanging != null))
			{
				this.PropertyChanging(this, emptyChangingEventArgs);
			}
		}
		
		protected virtual void SendPropertyChanged(String propertyName)
		{
			if ((this.PropertyChanged != null))
			{
				this.PropertyChanged(this, new PropertyChangedEventArgs(propertyName));
			}
		}
	}
}
#pragma warning restore 1591
